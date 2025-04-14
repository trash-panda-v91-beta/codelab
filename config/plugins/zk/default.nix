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
      key = "<leader>zn";
      action = "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>";
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
      key = "<leader>zf";
      action = ":'<,'>ZkMatch<CR>";
      options = {
        silent = true;
        desc = "Search for notes matching the selection";
      };
    }
  ];
}
