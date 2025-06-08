{ mcphub-nvim, ... }:
{
  extraPlugins = [ mcphub-nvim ];
  extraConfigLua = ''
    require("mcphub").setup()
  '';
}
