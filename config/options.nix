{ lib, ... }:
{
  options = {
    aiProvider = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Name of the AI provider";
            example = "copilot";
          };

          model = lib.mkOption {
            type = lib.types.str;
            description = "AI model to use";
            example = "claude-3.7-sonnet";
          };
        };
      };
      description = "Configuration for AI provider integration";
      default = {
        name = "copilot";
        model = "claude-3.7-sonnet";
      };
    };
  };

}
