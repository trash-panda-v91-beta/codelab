{ lib, pkgs, ... }:
{
  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        dap = {
          adapter = {
            command = lib.getExe' pkgs.lldb "lldb-dap";
            type = "executable";
          };
        };
      };
    };
  };
}
