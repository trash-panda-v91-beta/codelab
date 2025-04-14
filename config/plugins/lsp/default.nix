{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        bashls.enable = true;
        dockerls.enable = true;
        harper_ls.enable = true;
        html = {
          enable = true;
        };
        jsonls.enable = true;
        lua_ls = {
          enable = true;
          settings = {
            format = {
              enable = false;
            };
            telemetry = {
              enable = false;
            };
          };
        };
        nixd = {
          enable = true;
        };
        ruff = {
          enable = true;
        };
        basedpyright = {
          enable = true;
          settings = {
            disableOrganizeImports = true;
          };
        };
        sqls.enable = false;
        taplo.enable = true;
        ts_ls.enable = true;
        yamlls = {
          enable = true;
          extraOptions = {
            settings = {
              yaml = {
                customTags = [
                  "!And scalar"
                  "!And mapping"
                  "!And sequence"
                  "!If scalar"
                  "!If mapping"
                  "!If sequence"
                  "!Not scalar"
                  "!Not mapping"
                  "!Not sequence"
                  "!Equals scalar"
                  "!Equals mapping"
                  "!Equals sequence"
                  "!Or scalar"
                  "!Or mapping"
                  "!Or sequence"
                  "!FindInMap scalar"
                  "!FindInMap mapping"
                  "!FindInMap sequence"
                  "!Base64 scalar"
                  "!Base64 mapping"
                  "!Base64 sequence"
                  "!Cidr scalar"
                  "!Cidr mapping"
                  "!secret scalar"
                  "!include_dir_named scalar"
                  "!Cidr sequence"
                  "!Ref scalar"
                  "!Ref mapping"
                  "!Ref sequence"
                  "!Sub scalar"
                  "!Sub mapping"
                  "!Sub sequence"
                  "!GetAtt scalar"
                  "!GetAtt mapping"
                  "!GetAtt sequence"
                  "!GetAZs scalar"
                  "!GetAZs mapping"
                  "!GetAZs sequence"
                  "!ImportValue scalar"
                  "!ImportValue mapping"
                  "!ImportValue sequence"
                  "!Select scalar"
                  "!Select mapping"
                  "!Select sequence"
                  "!Split scalar"
                  "!Split mapping"
                  "!Split sequence"
                  "!Join scalar"
                  "!Join mapping"
                  "!Join sequence"
                ];
              };
            };
          };
        };
      };
      keymaps = {
        silent = true;
        diagnostic = {
          "[d" = {
            action = "goto_prev";
            desc = "Go to prev diagnostic";
          };
          "]d" = {
            action = "goto_next";
            desc = "Go to next diagnostic";
          };
          "<leader>ld" = {
            action = "open_float";
            desc = "Show Line Diagnostics";
          };
        };
        lspBuf = {
          "<leader>ca" = {
            action = "code_action";
            desc = "Code Actions";
          };
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          "<leader>K" = "hover";
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
      };
    };
  };
}
