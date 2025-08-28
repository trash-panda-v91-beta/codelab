{
  config,
  helpers,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) aiProvider;
in
{
  imports = [
    ./lualine.nix
    ./prompts.nix
  ];
  extraPlugins = [
    pkgs.vimPlugins.codecompanion-history-nvim
  ];
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
          tavily = {
            __raw = ''
              function()
                return require("codecompanion.adapters").extend("tavily", {
                  env = {
                    api_key = 'cmd:${lib.getExe pkgs._1password-cli} read "op://Private/op4p2ok4buizqra3jssnnoet3u/credential" --no-newline',
                  },
                })
               end                   
            '';
          };
        };
        display = {
          enabled = true;
          diff = {
            provider = "inline";
          };
          chat = {
            window = {
              layout = "horizontal";
              height = 0.5;
            };
          };
        };
        extensions = {
          history = {
            enabled = true;
            opts = {
              picker = "snacks";
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
            slash_commands = {
              search_notes = {
                description = "search notes";
                callback.__raw = ''
                  function(chat)
                    local picker = require("snacks.picker")
                    picker.pick(nil, {
                    source = "grep",
                    prompt = "Search notes: ",
                    confirm = function(_, selection)
                      if selection and selection.file then
                        local filepath = selection.file

                        local file = io.open(filepath, "r")
                        if not file then
                          vim.notify("Could not open file: " .. filepath, vim.log.levels.ERROR)
                          return
                        end

                        local content = file:read("*all")
                        file:close()

                        local ft = vim.filetype.match({ filename = filepath }) or ""

                        local relative_path = vim.fn.fnamemodify(filepath, ":.")
                        local id = "<file>" .. relative_path .. "</file>"
                        local formatted_content = string.format(
                          [[<attachment filepath="%s">Here is the content from the file:

                        ```%s
                        %s
                        ```
                        </attachment>]],
                          relative_path, ft, content
                        )
                        chat:add_message({
                          role = require("codecompanion.config").constants.USER_ROLE,
                          content = formatted_content
                        }, { context_id = id, visible = false })

                        chat.context:add({
                          id = id,
                          path = filepath,
                          source = "codecompanion.strategies.chat.slash_commands.search_notes"
                        })
                        vim.notify("Added file: " .. relative_path, vim.log.levels.INFO)
                      else
                        vim.notify("Selection object: " .. vim.inspect(selection), vim.log.levels.WARN)
                        vim.api.nvim_out_write(vim.inspect(selection))
                      end
                    end,
                  })
                  end
                '';
                opts = {
                  containes_code = false;
                };
              };
            };
          };
          inline = {
            adapter = aiProvider.name;
          };
        };
      };
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
