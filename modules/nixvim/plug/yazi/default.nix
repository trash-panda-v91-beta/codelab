{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    coreutils-prefixed
    yazi
  ];
  plugins.yazi = {
    enable = true;
  };
}
