{ config, lib, ... }:
{
  plugins.neotest = {
    enable = true;
    settings = {
      adapters = lib.optionals config.plugins.rustaceanvim.enable [
        # Lua
        ''require("rustaceanvim.neotest")''
      ];
    };
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
      action = "<cmd>Neotest output<CR>";
      options = {
        silent = true;
        desc = "Show test output";
      };
    }
    {
      mode = "n";
      key = "<leader>tp";
      action = "<cmd>Neotest output-panel<CR>";
      options = {
        silent = true;
        desc = "Show test output panel";
      };
    }
  ];
}
