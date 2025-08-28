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
          template = "day.md";
        };
        disable_frontmatter = true;
        follow_url_func.__raw = ''
          vim.fn.jobstart({ "open", url })
        '';
        note_id_func.__raw = ''
          function(title)
            return os.date("%Y%m%d%H%M%S")
          end
        '';
        new_notes_location = "notes_subdir";
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
  ];
}
