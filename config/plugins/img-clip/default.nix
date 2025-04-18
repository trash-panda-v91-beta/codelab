{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    pngpaste
  ];
  extraPlugins = [ pkgs.vimPlugins.img-clip-nvim ];
  extraConfigLua = ''require("img-clip").setup()'';

}
