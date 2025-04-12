{ lib, config, ... }:
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
        		{ "u", "d" },
        	},
        })
      '';

      lazyLoad.enable = false; # NOTE: it is already lazy-loaded
      settings = {
        preview = {
          callbacks.on_enable.__raw = ''
            function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "nc"
              vim.wo[win].wrap = false
            end
          '';
          ignore_buftypes = [ ];

          condition.__raw = ''
             function (buffer)
                local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt;
                if ft == "codecompanion" then
                     return true;
                elseif bt == "nofile" then
                     return false;
                else
                     return true;
                end
            end
          '';
          hybrid_modes = [ "i" ];
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
    blink-cmp = {
      settings.sources.per_filetype.markdown = [ "markview" ];
    };
  };
  keymaps = lib.mkIf config.plugins.spectre.enable [
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
