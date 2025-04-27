{
  plugins = {
    snacks = {
      settings = {
        picker = {
          actions = {
            trouble_open.__raw = ''
              function(...)
                return require("trouble.sources.snacks").actions.trouble_open.action(...)
              end
            '';
          };
          matcher = {
            frecency = true;
          };
          win = {
            input = {
              keys = {
                "<c-h>" = {
                  __unkeyed = "toggle_hidden";
                  mode = [
                    "n"
                    "i"
                  ];
                };
                "<c-t>" = {
                  __unkeyed = "trouble_open";
                  mode = [
                    "n"
                    "i"
                  ];
                };
                "<c-u>" = {
                  __unkeyed = "preview_scroll_up";
                  mode = [
                    "n"
                    "i"
                  ];
                };
                "<c-d>" = {
                  __unkeyed = "preview_scroll_down";
                  mode = [
                    "n"
                    "i"
                  ];
                };
              };
            };
          };
          layouts.default = {
            layout = {
              box = "vertical";
              backdrop = false;
              row = -1;
              width = 0;
              height = 0.4;
              border = "top";
              title = " {title} {live} {flags}";
              title_pos = "left";
              __unkeyed-1 = {
                win = "input";
                height = 1;
                border = "bottom";
              };
              __unkeyed-2 = {
                box = "horizontal";
                __unkeyed-1 = {
                  win = "list";
                  border = "none";
                };
                __unkeyed-2 = {
                  win = "preview";
                  title = "{preview}";
                  width = 0.6;
                  border = "left";
                };
              };
            };
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = ":lua Snacks.lazygit.open()<CR>";
      options = {
        desc = "Open LazyGit";
      };
    }
    {
      mode = "n";
      key = "<leader>fa";
      action = ''<cmd>lua Snacks.picker.autocmds()<cr>'';
      options = {
        desc = "Find autocmds";
      };
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = ''<cmd>lua Snacks.picker.diagnostics_buffer()<cr>'';
      options = {
        desc = "Find buffer diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>fD";
      action = ''<cmd>lua Snacks.picker.diagnostics()<cr>'';
      options = {
        desc = "Find workspace diagnostics";
      };
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = ''<cmd>lua Snacks.picker.help()<cr>'';
      options = {
        desc = "Find help tags";
      };
    }
    {
      mode = "n";
      key = "<leader>fk";
      action = ''<cmd>lua Snacks.picker.keymaps()<cr>'';
      options = {
        desc = "Find keymaps";
      };
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = ''<cmd>lua Snacks.picker.projects()<cr>'';
      options = {
        desc = "Find projects";
      };
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = ''<cmd>lua Snacks.picker.lsp_symbols()<cr>'';
      options = {
        desc = "Find lsp document symbols";
      };
    }
    {
      mode = "n";
      key = "<leader>fT";
      action = ''<cmd>lua Snacks.picker.colorschemes()<cr>'';
      options = {
        desc = "Find theme";
      };
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>lua Snacks.picker.grep()<cr>";
      options = {
        desc = "Live grep";
      };
    }
    {
      mode = "n";
      key = "<leader>fO";
      action = ''<cmd>lua Snacks.picker.smart()<cr>'';
      options = {
        desc = "Find Smart (Frecency)";
      };
    }
    {
      mode = "n";
      key = "<leader>f?";
      action = ''<cmd>lua Snacks.picker.grep_buffers()<cr>'';
      options = {
        desc = "Fuzzy find in open buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>f'";
      action = ''<cmd>lua Snacks.picker.marks()<cr>'';
      options = {
        desc = "Find marks";
      };
    }
    {
      mode = "n";
      key = "<leader>f/";
      action = ''<cmd>lua Snacks.picker.lines()<cr>'';
      options = {
        desc = "Fuzzy find in current buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = ''<cmd>lua Snacks.picker.resume()<cr>'';
      options = {
        desc = "Resume find";
      };
    }
    {
      mode = "n";
      key = "<leader>s";
      action = ''<cmd>lua Snacks.picker.buffers()<cr>'';
      options = {
        desc = "Find buffers";
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = ''<cmd>lua Snacks.picker.files()<cr>'';
      options = {
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader><space>";
      action = ''<cmd>lua Snacks.picker.files()<cr>'';
      options = {
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>fm";
      action = ''<cmd>lua Snacks.picker.man()<cr>'';
      options = {
        desc = "Find man pages";
      };
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = ''<cmd>lua Snacks.picker.recent()<cr>'';
      options = {
        desc = "Find old files";
      };
    }
    {
      mode = "n";
      key = "<leader>fq";
      action = ''<cmd>lua Snacks.picker.qflist()<cr>'';
      options = {
        desc = "Find quickfix";
      };
    }
    {
      mode = "n";
      key = "<leader>ld";
      action = ''<cmd>lua Snacks.picker.lsp_definitions()<cr>'';
      options = {
        desc = "Goto Definition";
      };
    }
    {
      mode = "n";
      key = "<leader>li";
      action = ''<cmd>lua Snacks.picker.lsp_implementation()<cr>'';
      options = {
        desc = "Goto Implementation";
      };
    }
    {
      mode = "n";
      key = "<leader>lD";
      action = ''<cmd>lua Snacks.picker.lsp_references()<cr>'';
      options = {
        desc = "Find references";
      };
    }
    {
      mode = "n";
      key = "<leader>lt";
      action = ''<cmd>lua Snacks.picker.lsp_type_definitions()<cr>'';
      options = {
        desc = "Goto Type Definition";
      };
    }
    {
      mode = "n";
      key = "<leader>fS";
      action = ''<cmd>lua Snacks.picker.spell_suggest()<cr>'';
      options = {
        desc = "Find spelling suggestions";
      };
    }
    {
      mode = "n";
      key = "<leader>fH";
      action = ''<cmd>lua Snacks.picker.highlights()<cr>'';
      options = {
        desc = "Find highlights";
      };
    }
    {
      mode = "n";
      key = "<leader>gB";
      action = ''<cmd>lua Snacks.picker.git_branches()<cr>'';
      options = {
        desc = "Find git branches";
      };
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = ''<cmd>lua Snacks.picker.git_log()<cr>'';
      options = {
        desc = "Git log";
      };
    }
    {
      mode = "n";
      key = "<leader>gf";
      action = ''<cmd>lua Snacks.picker.git_log_file()<cr>'';
      options = {
        desc = "Git log file";
      };
    }
    {
      mode = "n";
      key = "<leader>gL";
      action = ''<cmd>lua Snacks.picker.git_log_line()<cr>'';
      options = {
        desc = "Git log line";
      };
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = ''<cmd>lua Snacks.picker.git_status()<cr>'';
      options = {
        desc = "Find git status";
      };
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = ''<cmd>lua Snacks.picker.git_stash()<cr>'';
      options = {
        desc = "Find git stashes";
      };
    }
  ];
}
