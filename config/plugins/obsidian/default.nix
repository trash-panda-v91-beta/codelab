{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPlugins = [ pkgs.vimPlugins.plenary-nvim ];
  plugins = {
    obsidian = {
      enable = true;
      settings = {
        completion = {
          blink = true;
          nvim_cmp = false;
        };
        daily_notes = {
          folder = "journal";
          default_tags = [ "day" ];
          date_format = "%Y/%m/%Y-%m-%d";
          alias_format = "%B %-d, %Y";
        };
        disable_frontmatter = false;
        follow_url_func.__raw = ''
          vim.fn.jobstart({ "open", url })
        '';
        new_notes_location = "notes_subdir";
        note_frontmatter_func.__raw = ''
          function(note)
            if note.title then
              note:add_alias(note.title)
            end
            local out = { id = note.id, aliases = note.aliases, tags = note.tags, title = note.title }
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end
            return out
          end
        '';
        legacy_commands = false;
        picker = {
          name = "snacks.pick";
        };
        templates = {
          subdir = "templates";
        };
        workspaces = [
          {
            name = "personal";
            path = "~/notes";
          }
        ];
        ui.enable = false;
      };
    };
  };
  keymaps = lib.mkIf config.plugins.obsidian.enable [
    {
      mode = "n";
      key = "<leader>nt";
      action = "<Cmd>Obsidian today<CR>";
      options = {
        silent = true;
        desc = "Create/open today's note";
      };
    }
    {
      mode = "n";
      key = "<leader>nw";
      action = "<Cmd>Obsidian new work/<CR>";
      options = {
        silent = true;
        desc = "Create new work related note";
      };
    }
    {
      mode = "n";
      key = "<leader>nn";
      action = "<Cmd>Obsidian new<CR>";
      options = {
        silent = true;
        desc = "Create new note";
      };
    }
    {
      mode = "n";
      key = "<leader>nf";
      action = "<Cmd>Obsidian follow_link<CR>";
      options = {
        silent = true;
        desc = "Follow link under cursor";
      };
    }
  ];
}
