{
  description = ".code-editor";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixvim.url = "github:nix-community/nixvim";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";

    snacks-nvim = {
      url = "github:folke/snacks.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      treefmt-nix,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = fn: nixpkgs.lib.genAttrs systems fn;
      nixpkgsConfig = {
        allowUnfree = true;
      };
      treefmtEval = forAllSystems (
        system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );
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
            pkgs = import nixpkgs {
              inherit system;
              config = nixpkgsConfig;
            };
            extraSpecialArgs = {
              inherit
                inputs
                self
                helpers
                system
                ;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          default = nvim;
        }
      );

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });
    };
}
