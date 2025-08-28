{
  lib,
  config,
  ...
}:
{
  plugins = {
    diffview = {
      enable = true;
    };
  };

  keymaps = lib.mkIf config.plugins.diffview.enable [
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = ''
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end
      '';
      options = {
        desc = "Toggle diff view";
      };
    }
  ];
}
