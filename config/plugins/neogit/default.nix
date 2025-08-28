{ lib, config, ... }:
{
  plugins = {
    neogit = {
      enable = true;
    };
  };

  keymaps = lib.mkIf config.plugins.markview.enable [
    {
      mode = [
        "n"
        "i"
      ];
      key = "<leader>gn";
      action = "<cmd>Neogit<cr>";
      options = {
        desc = "Open Neogit";
      };
    }
  ];
}
