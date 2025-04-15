{
  lib,
  ...
}:
let
  inherit (builtins) readDir;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.lists) optional;
  by-name = ./plugins;
in
{
  imports =
    (foldlAttrs (
      prev: name: type:
      prev ++ optional (type == "directory") (by-name + "/${name}")
    ) [ ] (readDir by-name))
    ++ [
      ./autocmd.nix
      ./filetypes.nix
      ./files.nix
      ./keys.nix
      ./options.nix
      ./sets.nix
    ];
}
