{ config, lib, ... }:
{
  plugins = {
    fastaction = {
      enable = true;
    };

  };
  keymaps = lib.mkIf config.plugins.fastaction.enable [
    {
      mode = [
        "n"
      ];
      key = "<leader>ca";
      action = "<cmd>lua require('fastaction').code_action()<CR>";
      options = {
        desc = "Display code actions";
        buffer.__raw = "bufnr";
      };
    }
  ];
}
