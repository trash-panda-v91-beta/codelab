{ lib, ... }:
{
  options = {
    ai-provider = lib.mkOption {
      default = "copilot";
      type = lib.types.enum [
        "copilot"
        "anthropic"
      ];
    };
  };

}
