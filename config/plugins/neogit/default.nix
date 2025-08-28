{ lib, config, ... }:
{
  plugins = {
    neogit = {
      enable = true;
    };
  };

  keymaps = lib.mkIf config.plugins.neogit.enable [
    {
      mode = [
        "n"
      ];
      key = "<leader>gg";
      action = "<cmd>Neogit<cr>";
      options = {
        desc = "Open Neogit";
      };
    }
  ];
}
