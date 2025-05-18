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
        flake = ''(getFlake "${self}")'';
        system = "$currentSystem}";
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
