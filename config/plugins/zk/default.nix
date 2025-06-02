{ config, lib, ... }:
{
  plugins.zk = {
    enable = true;
    settings = {
      lsp = {
        auto_attach = {
          enabled = true;
          filetypes = [
            "markdown"
          ];
        };
        config = {
          cmd = [
            "zk"
            "lsp"
          ];
          name = "zk";
        };
      };
      picker = "snacks_picker";
    };
  };
  keymaps = lib.mkIf config.plugins.zk.enable [
    {
      mode = "n";
      key = "<leader>zj";
      action = "<Cmd>ZkNew { group = 'journal',  }<CR>";
      options = {
        silent = true;
        desc = "Create new journal note";
      };
    }
    {
      mode = "n";
      key = "<leader>zc";
      action = "<Cmd>ZkNew { group = 'corporate',  }<CR>";
      options = {
        silent = true;
        desc = "Create new corporate note";
      };
    }
    {
      mode = "n";
      key = "<leader>zn";
      action = "<Cmd>ZkNew { group = 'personal',  }<CR>";
      options = {
        silent = true;
        desc = "Create new note";
      };
    }
    {
      mode = "n";
      key = "<leader>zo";
      action = "<Cmd>ZkNotes { sort = { 'modified' } }<CR>";
      options = {
        silent = true;
        desc = "Open notes";
      };
    }
    {
      mode = "n";
      key = "<leader>zb";
      action = "<Cmd>ZkBacklins<CR>";
      options = {
        silent = true;
        desc = "Open notes";
      };
    }
    {
      mode = "n";
      key = "<leader>zt";
      action = "<Cmd>ZkTags<CR>";
      options = {
        silent = true;
        desc = "Search for tags";
      };
    }
    {
      mode = "n";
      key = "<leader>zf";
      action = "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>";
      options = {
        silent = true;
        desc = "Search for notes matching a query";
      };
    }
    {
      mode = "v";
      key = "<leader>zn";
      action = ":'<,'>ZkNewFromTitleSelection { group = 'personal'  }<CR>";
      options = {
        silent = true;
        desc = "Link personal note";
      };
    }
    {
      mode = "v";
      key = "<leader>zc";
      action = ":'<,'>ZkNewFromTitleSelection { group = 'corporate'  }<CR>";
      options = {
        silent = true;
        desc = "Link corporate note";
      };
    }
    {
      mode = "v";
      key = "<leader>zf";
      action = ":'<,'>ZkMatch<CR>";
      options = {
        silent = true;
        desc = "Search for notes matching the selection";
      };
    }
  ];
}
