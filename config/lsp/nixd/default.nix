{
  lib,
  pkgs,
  self,
  ...
}:
{
  lsp.servers.nixd = {
    enable = true;

    settings.settings =
      let
        flake = ''(builtins.getFlake "${self}")'';
        system = ''''${builtins.currentSystem}'';
      in
      {
        nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
        formatting = {
          command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
        };
        options = {
          nixvim.expr = ''${flake}.packages.${system}.nvim.options'';
        };
      };
  };
}
