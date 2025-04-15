{
  config,
  helpers,
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
  inherit (config) ai-provider;
in
{
  plugins = {
    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          copilot.__raw =
            helpers.mkLuaFn
              # Lua
              ''
                return require("codecompanion.adapters").extend("copilot", {
                	schema = {
                		model = {
                			default = "claude-3.7-sonnet",
                		},
                	},
                })
              '';
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
            adapter = ai-provider;
          };
          chat = {
            adapter = ai-provider;
            keymaps = {
              send = {
                modes = {
                  n = "s";
                };
              };
            };
          };
          inline = {
            adapter = ai-provider;
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
