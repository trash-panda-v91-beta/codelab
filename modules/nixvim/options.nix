{ lib, ... }:
{
  options = {
    theme = lib.mkOption {
      default = lib.mkDefault "oxocarbon";
      type = lib.types.enum [
        "aquarium"
        "cyberdream"
        "decay"
        "edge-dark"
        "everblush"
        "everforest"
        "far"
        "gruvbox"
        "jellybeans"
        "material"
        "material-darker"
        "mountain"
        "ocean"
        "oxocarbon"
        "paradise"
        "test"
        "tokyonight"
        "radium"
        "yoru"
      ];
    };
    assistant = lib.mkOption {
      default = "none";
      type = lib.types.enum [
        "copilot"
        "none"
      ];
    };
  };
}
