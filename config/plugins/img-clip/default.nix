{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    (if stdenv.isDarwin then pngpaste else wl-clipboard)
  ];
  extraPlugins = [ pkgs.vimPlugins.img-clip-nvim ];
  extraConfigLua = ''require("img-clip").setup()'';
}
