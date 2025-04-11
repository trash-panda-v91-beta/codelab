{
  description = ".code-editor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";

    snacks-nvim = {
      url = "github:folke/snacks.nvim";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, nixvim, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = fn: nixpkgs.lib.genAttrs systems fn;
    in
    {
      packages = forAllSystems (
        system:
        let
          nixvimLib = inputs.nixvim.lib;
          helpers = nixvimLib.nixvim // {
            mkLuaFnWithName =
              name: lua:
              # lua
              ''
                function ${name}()
                  ${lua}
                end
              '';

            mkLuaFn =
              lua: # lua
              ''
                function()
                  ${lua}
                end
              '';
          };
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = { inherit inputs helpers; };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          default = nvim;
        }
      );

      checks = forAllSystems (
        system:
        let
          nixvimLib = nixvim.lib.${system};
          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = { inherit inputs; };
          };
        in
        {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        }
      );
    };
}
