{
  config,
  lib,
  pkgs,
  ...
}:
{
  extraPackages =
    lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      [
        pkgs.ripgrep
      ];
  plugins = {
    snacks = {
      settings = {
        picker = {
          formatters = {
            file = {
              filename_first = true;
              truncate = 90;
            };
          };
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
                "<c-x>" = {
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
  keymaps =
    lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      [
        {
          mode = "n";
          key = "<leader><space>";
          action = ''<cmd>lua Snacks.picker.smart()<cr>'';
          options = {
            desc = "Smart Find Files";
          };
        }
        {
          mode = "n";
          key = "<leader>:";
          action = ''<cmd>lua Snacks.picker.command_history()<cr>'';
          options = {
            desc = "Command History";
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
          key = "<leader>fb";
          action = ''<cmd>lua Snacks.picker.buffers()<cr>'';
          options = {
            desc = "Find buffers";
          };
        }
        {
          mode = "n";
          key = "<leader>fc";
          action = ''<cmd>lua Snacks.picker.commands()<cr>'';
          options = {
            desc = "Find commands";
          };
        }
        {
          mode = "n";
          key = "<leader>fC";
          action.__raw = ''
            function()
              require("snacks.picker").files {
                prompt_title = "Config Files",
                cwd = vim.fn.stdpath("config"),
              }
            end
          '';
          options = {
            desc = "Find config files";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fe";
          action = ''<cmd>lua Snacks.explorer()<cr>'';
          options = {
            desc = "File Explorer";
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
          key = "<leader>fF";
          action = ''<cmd>lua Snacks.picker.files({hidden = true, ignored = true})<cr>'';
          options = {
            desc = "Find files (All files)";
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
          key = "<leader>fO";
          action = ''<cmd>lua Snacks.picker.smart()<cr>'';
          options = {
            desc = "Find Smart (Frecency)";
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
          key = "<leader>fq";
          action = ''<cmd>lua Snacks.picker.qflist()<cr>'';
          options = {
            desc = "Find quickfix";
          };
        }
        {
          mode = "n";
          key = "<leader>fr";
          action = ''<cmd>lua Snacks.picker.registers()<cr>'';
          options = {
            desc = "Find registers";
          };
        }
        {
          mode = "n";
          key = "<leader>fS";
          action = ''<CMD>lua Snacks.picker.spelling({layout = { preset = "select" }})<CR>'';
          options = {
            desc = "Find spelling suggestions";
          };
        }
        # Moved to todo-comments module since lazy loading wasn't working
        (lib.mkIf (!config.plugins.todo-comments.lazyLoad.enable) {
          mode = "n";
          key = "<leader>ft";
          action = ''<cmd>lua Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" }})<cr>'';
          options = {
            desc = "Find TODOs";
          };
        })
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
          key = "<leader>fu";
          action = "<cmd>lua Snacks.picker.undo()<cr>";
          options = {
            desc = "Undo History";
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
          key = "<leader>fW";
          action = "<cmd>lua Snacks.picker.grep({hidden = true, ignored = true})<cr>";
          options = {
            desc = "Live grep (All files)";
          };
        }
        {
          mode = "n";
          key = "<leader>f,";
          action = ''<cmd>lua Snacks.picker.icons({layout = { preset = "select" }})<cr>'';
          options = {
            desc = "Find icons";
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
          key = "<leader>f?";
          action = ''<cmd>lua Snacks.picker.grep_buffers()<cr>'';
          options = {
            desc = "Fuzzy find in open buffers";
          };
        }
        {
          mode = "n";
          key = "<leader>f<CR>";
          action = ''<cmd>lua Snacks.picker.resume()<cr>'';
          options = {
            desc = "Resume find";
          };
        }

        {
          mode = [
            "n"
            "x"
          ];
          key = "<leader>sw";
          action = ''<cmd>lua Snacks.picker.grep_word()<cr>'';
          options = {
            desc = "Search Word (visual or cursor)";
          };
        }

        {
          mode = "n";
          key = "<leader>uC";
          action = ''<cmd>lua Snacks.picker.colorschemes()<cr>'';
          options = {
            desc = "Colorschemes";
          };
        }
        {
          mode = "n";
          key = "<leader>X";
          action = ''<cmd>lua Snacks.profiler.toggle()<cr>'';
          options = {
            desc = "Toggle Neovim profiler";
          };
        }
        {
          mode = "n";
          key = "<leader>fG";
          action = ''<cmd>lua Snacks.picker.git_files()<cr>'';
          options = {
            desc = "Find Git Files";
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
          key = "<leader>gC";
          action = ''<cmd>lua Snacks.picker.git_log()<cr>'';
          options = {
            desc = "Find git commits";
          };
        }
        {
          mode = "n";
          key = "<leader>gL";
          action = ''<cmd>lua Snacks.picker.git_log_line()<cr>'';
          options = {
            desc = "Git Log Line";
          };
        }
        {
          mode = "n";
          key = "<leader>gd";
          action = ''<cmd>lua Snacks.picker.git_diff()<cr>'';
          options = {
            desc = "Git Diff (Hunks)";
          };
        }
        {
          mode = "n";
          key = "<leader>gf";
          action = ''<cmd>lua Snacks.picker.git_log_file()<cr>'';
          options = {
            desc = "Git Log File";
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
          key = "<leader>fs";
          action = ''<cmd>lua Snacks.picker.lsp_symbols()<cr>'';
          options = {
            desc = "Find lsp document symbols";
          };
        }

        {
          mode = "n";
          key = "<leader>la";
          action = ''<cmd>lua Snacks.picker.lsp_code_actions()<cr>'';
          options = {
            desc = "Code Action";
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
          action = ''<cmd>lua Snacks.picker.lsp_implementations()<cr>'';
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
          key = "gd";
          action = ''<cmd>lua Snacks.picker.lsp_definitions()<cr>'';
          options = {
            desc = "Goto Definition";
          };
        }
        {
          mode = "n";
          key = "gD";
          action = ''<cmd>lua Snacks.picker.lsp_declarations()<cr>'';
          options = {
            desc = "Goto Declaration";
          };
        }
        {
          mode = "n";
          key = "gR";
          action = ''<cmd>lua Snacks.picker.lsp_references()<cr>'';
          options = {
            desc = "References";
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "gI";
          action = ''<cmd>lua Snacks.picker.lsp_implementations()<cr>'';
          options = {
            desc = "Goto Implementation";
          };
        }
        {
          mode = "n";
          key = "gy";
          action = ''<cmd>lua Snacks.picker.lsp_type_definitions()<cr>'';
          options = {
            desc = "Goto T[y]pe Definition";
          };
        }
      ];
}
