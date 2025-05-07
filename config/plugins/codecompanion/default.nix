{
  config,
  helpers,
  lib,
  ...
}:
let
  lualine_component = ''
    (function()
         local M = require("lualine.component"):extend()

         M.processing = false
         M.spinner_index = 1

         local spinner_symbols = {
           "⠋",
           "⠙",
           "⠹",
           "⠸",
           "⠼",
           "⠴",
           "⠦",
           "⠧",
           "⠇",
           "⠏",
         }
         local spinner_symbols_len = 10

         -- Initializer
         function M:init(options)
           M.super.init(self, options)

           local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

           vim.api.nvim_create_autocmd({ "User" }, {
             pattern = "CodeCompanionRequest*",
             group = group,
             callback = function(request)
               if request.match == "CodeCompanionRequestStarted" then
                 self.processing = true
               elseif request.match == "CodeCompanionRequestFinished" then
                 self.processing = false
               end
             end,
           })
         end

         -- Function that runs every time statusline is updated
         function M:update_status()
           if self.processing then
             self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
             return spinner_symbols[self.spinner_index]
           else
             return nil
           end
         end

         return M
    end)()
  '';
  inherit (config) aiProvider;
in
{
  plugins = {
    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          copilot = lib.mkIf (aiProvider.model != null) {
            __raw =
              helpers.mkLuaFn
                # Lua
                ''
                  return require("codecompanion.adapters").extend("copilot", {
                  	schema = {
                  		model = {
                  			default = "${aiProvider.model}",
                  		},
                  	},
                  })
                '';
          };
        };
        display = {
          enabled = true;
          diff = {
            provider = "mini_diff";
          };
          chat = {
            window = {
              layout = "horizontal";
              height = 0.5;
            };
          };
        };
        strategies = {
          agent = {
            adapter = aiProvider.name;
          };
          chat = {
            adapter = aiProvider.name;
            keymaps = {
              send = {
                modes = {
                  n = "s";
                };
              };
            };
          };
          inline = {
            adapter = aiProvider.name;
          };
        };
        prompt_library = {
          "Smart Paste" = {
            strategy = "inline";
            description = "Paste code smartly";
            opts = {
              short_name = "paste";
            };
            prompts = [
              {
                role = "system";
                content = ''
                  You are a smart code paste agent within Neovim.

                  ## **Task:** Intelligently integrate content from the user's clipboard into the current buffer.

                  ## **Instructions:**

                  -   You may receive code in various programming languages or even natural language instructions.
                  -   If the clipboard content is in a different language than the current buffer, translate it to the appropriate language smartly.
                  -   If the clipboard content contains psudo code generate code accordingly.
                  -   If the clipboard content contains natural language instructions, interpret and follow them to modify the code in the current buffer.
                  -   **ONLY** generate the **new** lines of code required for seamless integration.
                  -   Ensure the inserted code is syntactically correct and logically consistent with the existing code.
                  -   Do **NOT** include surrounding code or line numbers.
                  -   Make sure all brackets and quotes are closed properly.

                  ## **Output:**

                  -   Provide only the necessary lines of code for insertion.
                  -   If you can't generate code just return nothing.
                  -   Ensure the response is proper and well-formatted.
                '';
              }
              {
                role = "user";
                content.__raw = ''
                    function(context)
                    local lines = require('codecompanion.helpers.actions').get_code(1, context.line_count, { show_line_numbers = true })
                    local selection_info = ""
                    local clipboard = vim.fn.getreg '+'

                    if context.is_visual then
                      selection_info = string.format('Currently selected lines: %d-%d', context.start_line, context.end_line)
                    else
                      selection_info = string.format('Current cursor line: %d and Current cursor column is %d', context.cursor_pos[1], context.cursor_pos[2])
                    end

                    return string.format(
                      'I have the following code:\n\n```%s\n%s\n```\n\nClipboard content:\n\n```\n%s\n```\n\n%s',
                      context.filetype,
                      lines,
                      clipboard,
                      selection_info
                    )
                  end'';
                opts = {
                  contains_code = true;
                };
              }
            ];
          };
          "Text Revision" = {
            strategy = "inline";
            description = "Revise the text";
            opts = {
              mapping = "<leader>rt";
              auto_submit = true;
              user_prompt = false;
              stop_context_insertion = true;
              short_name = "textexpert";
              placement = "replace";
            };
            prompts = [
              {
                role = "system";
                content = "You are a senior text editor specializing in improving written content. Your tasks include: correcting grammar and spelling errors, improving sentence structure, enhancing clarity and flow, making text sound more natural to native speakers, and ensuring proper Markdown formatting. Provide specific explanations for significant changes, maintain the author's original meaning and tone, and focus on making text professional and polished. When possible, offer brief alternative phrasings for improved sections.";
              }
              {
                role = "user";
                content.__raw = ''
                  function(context)
                    local lines = require('codecompanion.helpers.actions').get_code(1, context.line_count, { show_line_numbers = true })
                    local selection_info = ""
                    local clipboard = vim.fn.getreg '+'

                    if context.is_visual then
                      selection_info = string.format('Currently selected lines: %d-%d', context.start_line, context.end_line)
                    else
                      selection_info = string.format('Currently selected lines: %d-%d', 1, context.line_count)
                    end

                    return string.format(
                      'I have the following text:\n\n```%s\n%s\n```\n\n%s',
                      context.filetype,
                      lines,
                      selection_info
                    )
                  end'';
              }
            ];
          };
          "Diff code review" = {
            strategy = "chat";
            description = "Perform a code review";
            opts = {
              auto_submit = true;
              user_prompt = false;
            };
            prompts = [
              {
                role = "user";
                content.__raw = ''
                  function()
                    local target_branch = vim.fn.input("Target branch for merge base diff (default: main): ", "main")

                    return string.format(
                      [[
                      You are a senior software engineer performing a code review. Analyze the following code changes.
                       Identify any potential bugs, performance issues, security vulnerabilities, or areas that could be refactored for better readability or maintainability.
                       Explain your reasoning clearly and provide specific suggestions for improvement.
                       Consider edge cases, error handling, and adherence to best practices and coding standards.
                       Here are the code changes:
                       ```
                        %s
                       ```
                       ]],
                      vim.fn.system("git diff --merge-base " .. target_branch)
                    )
                  end
                '';
              }
            ];
          };
        };
      };
    };
    lualine.settings = {
      sections.lualine_x = [
        {
          __unkeyed.__raw = lualine_component;
        }
      ];
      extensions = [
        {
          filetypes = [ "codecompanion" ];
          sections = {
            lualine_a = [
              {
                __unkeyed = "mode";
                fmt.__raw = ''
                  function(mode)
                    return mode:lower()
                  end
                '';
                icon = "";
              }
            ];

            lualine_b = {
              __unkeyed.__raw = ''
                function()
                  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
                  if not chat then
                    return nil
                  end
                  return " " .. chat.adapter.formatted_name
                end
              '';
            };
            lualine_c = {
              __unkeyed.__raw = ''
                function()
                  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
                  if not chat then
                    return nil
                  end
                  return chat.settings.model
                end
              '';
            };
            lualine_x = {
              __unkeyed.__raw = lualine_component;
            };
            lualine_y = {
              __unkeyed = "progress";
            };
            lualine_z = {
              __unkeyed = "location";
            };
          };
          inactive_sections = {
            lualine_a = { };
            lualine_b = {
              __unkeyed.__raw = ''
                function()
                  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
                  if not chat then
                    return nil
                  end
                  return " " .. chat.adapter.formatted_name
                end
              '';
            };
            lualine_c = { };
            lualine_x = { };
            lualine_y = {
              __unkeyed = "progress";
            };
            lualine_z = { };
          };
        }
      ];
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<A-c>";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      options = {
        desc = "Trigger CodeCompanion chat";
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<A-i>";
      action = "<cmd>CodeCompanion<CR>";
      options = {
        desc = "Trigger CodeCompanion inline";
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<localleader>aa";
      action = "<cmd>CodeCompanionActions<CR>";
      options = {
        desc = "Trigger CodeCompanion actions";
        silent = true;
      };
    }
  ];
}
