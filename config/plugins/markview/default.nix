{
  plugins = {
    markview = {
      enable = true;
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
                { "u", "d" }
            }
        })
      '';

      lazyLoad.enable = false; # NOTE: it is already lazy-loaded
      settings = {
        html.enable = true;
        latex.enable = true;

        preview = {
          callbacks.on_enable.__raw = ''
            function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "nc"
              vim.wo[win].wrap = false
            end
          '';
          hybrid_modes = [
            "i"
          ];
          modes = [
            "n"
            "i"
            "nc"
            "c"
          ];
        };
      };
    };
    blink-cmp = {
      settings.sources.per_filetype.markdown = [ "markview" ];
    };
  };
  keymaps = [
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
