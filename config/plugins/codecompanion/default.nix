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
    (import ./prompts.nix { inherit lib pkgs; })
    ./tools.nix
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
