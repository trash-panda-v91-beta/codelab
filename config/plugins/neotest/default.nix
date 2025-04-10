{
  plugins.neotest = {
    enable = true;
    adapters = {
      python = {
        enable = true;
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>Neotest run file<CR>";
      options = {
        silent = true;
        desc = "Run test for a file";
      };
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>Neotest run<CR>";
      options = {
        silent = true;
        desc = "Run test for a function";
      };
    }
    {
      mode = "n";
      key = "<leader>tl";
      action = "<cmd>Neotest run last<CR>";
      options = {
        silent = true;
        desc = "Run last test";
      };
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<cmd>Neotest summary<CR>";
      options = {
        silent = true;
        desc = "Show test summary";
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>Neotest output-panel<CR>";
      options = {
        silent = true;
        desc = "Show test output";
      };
    }
  ];
}
