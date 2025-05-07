{ config, ... }:
{
  plugins = {
    lsp-signature.enable = config.plugins.lsp.enable;
  };
}
