{ lib, config, ... }:
{
  plugins = {
    markview = {
      enable = false;
      luaConfig.post = ''
        require("markview.extras.checkboxes").setup({
        	default = "X",
        	remove_style = "disable",
        	states = {
        		{ " ", "/", "X" },
        		{ "<", ">" },
        		{ "?", "!", "*" },
        		{ '"' },
        		{ "l", "b", "i" },
        		{ "S", "I" },
        		{ "p", "c" },
        		{ "f", "k", "w" },
        		{ "u", "d" },
        	},
        })
      '';

      lazyLoad.enable = false; # NOTE: it is already lazy-loaded
      settings = {
        markdown = {
          headings.__raw = "require('markview.presets').headings.glow";
          code_blocks = {
            default = {
              block_hl = "";
            };
            border_hl = "";
          };
          metadata_minus = {
            hl = "";
            border_top = "";
            border_bottom = "";
          };
        };
        preview = {
          callbacks.on_enable.__raw = ''
            function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "nc"
              vim.wo[win].wrap = false
            end
          '';
          ignore_buftypes = [ ];
          linewise_hybrid_mode = true;
          hybrid_modes = [
            "i"
            "n"
          ];
          modes = [
            "i"
            "n"
            "no"
            "c"
          ];
          filetypes = [
            "md"
            "markdown"
            "Avante"
            "codecompanion"
          ];
        };
      };
    };
  };
  extraFiles = lib.mkIf config.plugins.markview.enable {
    "queries/markdown/folds.scm".text = ''
      ; Folds a section of the document
      ; that starts with a heading.
      ((section
          (atx_heading)) @fold
          (#trim! @fold))

      ; (#trim!) is used to prevent empty
      ; lines at the end of the section
      ; from being folded.
    '';
  };
  keymaps = lib.mkIf config.plugins.markview.enable [
    {
      mode = [
        "n"
        "i"
      ];
      key = "<M-d>";
      action = "<cmd>Checkbox toggle<cr>";
      options = {
        desc = "Toggle Checkbox";
      };
    }
  ];
}
