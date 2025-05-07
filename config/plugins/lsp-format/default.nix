{ config, ... }:
{
  plugins = {
    lsp-format.enable = !config.plugins.conform-nvim.enable && config.plugins.lsp.enable;
  };
}
