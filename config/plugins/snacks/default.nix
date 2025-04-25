{ inputs, pkgs, ... }:
{
  plugins.snacks = {
    enable = true;
    package = pkgs.callPackage ../../../packages/snacks-nvim {
      inherit inputs;
    };
  };
  imports = [
    ./animate.nix
    ./bigfile.nix
    ./dashboard.nix
    ./git.nix
    ./indent.nix
    ./lazygit.nix
    ./notifier.nix
    ./picker.nix
    ./scope.nix
  ];

}
