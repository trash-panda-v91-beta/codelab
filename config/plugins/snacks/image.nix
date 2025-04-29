{ pkgs, ... }:
{
  extraPackages = with pkgs; [ imagemagick ];
  plugins.snacks = {
    settings = {
      image = {
        enabled = true;
      };
    };
  };
}
