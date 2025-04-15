{ config, ... }:
let
  inherit (config) ai-provider;
in
{
  plugins.avante = {
    enable = false;

    lazyLoad.settings.event = [ "BufEnter" ];
    settings = {
      mappings = {
        files = {
          add_current = "<leader>a.";
        };
      };
      diff = {
        autojump = true;
        debug = false;
        list_opener = "copen";
      };
      highlights = {
        diff = {
          current = "DiffText";
          incoming = "DiffAdd";
        };
      };
      hints = {
        enabled = true;
      };
      mappings = {
        diff = {
          both = "cb";
          next = "]x";
          none = "c0";
          ours = "co";
          prev = "[x";
          theirs = "tc";
        };
      };
      provider = ai-provider;
      windows = {
        sidebar_header = {
          align = "center";
          rounded = true;
        };
        width = 30;
        wrap = true;
      };
    };
  };
}
