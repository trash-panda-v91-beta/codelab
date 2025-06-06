{ config, lib, ... }:
{
  plugins = {
    kulala = {
      enable = true;
      settings = {
        global_keymaps = true;
        global_keymaps_prefix = "<leader>h";
        kulala_keymaps_prefix = "";
        ui = {
          split_direction = "horizontal";
        };
      };
    };
  };

  keymaps = lib.mkIf config.plugins.kulala.enable [

  ];
}
