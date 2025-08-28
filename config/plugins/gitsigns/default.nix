{ config, lib, ... }:
{
  plugins.gitsigns = {
    enable = true;
    settings = {
      trouble = true;
      current_line_blame = true;
      current_line_blame_formatter = "   <author>, <committer_time:%R> • <summary>";
      on_attach.__raw = ''
         function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('n', '<leader>gs', gitsigns.stage_hunk)
          map('n', '<leader>gr', gitsigns.reset_hunk)

          map('v', '<leader>gs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('v', '<leader>gr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          map('n', '<leader>gS', gitsigns.stage_buffer)
          map('n', '<leader>gR', gitsigns.reset_buffer)
          map('n', '<leader>ghp', gitsigns.preview_hunk)
          map('n', '<leader>ghi', gitsigns.preview_hunk_inline)

          map('n', '<leader>ghb', function()
            gitsigns.blame_line({ full = true })
          end)

          map('n', '<leader>ghd', gitsigns.diffthis)

          map('n', '<leader>ghD', function()
            gitsigns.diffthis('~')
          end)

          map('n', '<leader>ghQ', function() gitsigns.setqflist('all') end)
          map('n', '<leader>ghq', gitsigns.setqflist)

          map('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>gtw', gitsigns.toggle_word_diff)

          map({'o', 'x'}, 'ih', gitsigns.select_hunk)
        end   
      '';
    };
  };
  keymaps = lib.mkIf config.plugins.gitsigns.enable [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>gh";
      action = "gitsigns";
      options = {
        silent = true;
        desc = "+hunks";
      };
    }
    {
      mode = "n";
      key = "<leader>ghb";
      action = ":Gitsigns blame_line<CR>";
      options = {
        silent = true;
        desc = "Blame line";
      };
    }
    {
      mode = "n";
      key = "<leader>ghd";
      action = ":Gitsigns diffthis<CR>";
      options = {
        silent = true;
        desc = "Diff This";
      };
    }
    {
      mode = "n";
      key = "<leader>ghR";
      action = ":Gitsigns reset_buffer<CR>";
      options = {
        silent = true;
        desc = "Reset Buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>ghS";
      action = ":Gitsigns stage_buffer<CR>";
      options = {
        silent = true;
        desc = "Stage Buffer";
      };
    }
  ];
}
