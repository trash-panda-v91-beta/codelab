{
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    lsp-format = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        html = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        ruff = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        bashls = {
          enable = true;
        };
        taplo = {
          enable = true;
        };
        dockerls = {
          enable = true;
        };
        nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "github:aka-raccoon/spacewim)""'';
              flakeNixvim = ''(builtins.getFlake "github:aka-raccoon/spacewim)""'';
            in
            {
              nixpkgs = {
                expr = "import ${flake}.inputs.nixpkgs { }";
              };
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options = {
                nixos.expr = ''${flake}.nixosConfigurations.grovetender.options'';
                nixvim.expr = ''${flakeNixvim}.packages.${pkgs.system}.default.options'';
              };
            };
        };
        markdown_oxide = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        yamlls = {
          enable = true;
          extraOptions = {

            settings = {
              yaml = {
                schemas = {
                  "https://json.schemastore.org/yamllint.json" = "template.yaml";
                };
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
                  "!FindInMap mappping"
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
        lspBuf = {
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
          # Use LSP saga keybinding instead
          # K = {
          #   action = "hover";
          #   desc = "Hover";
          # };
          # "<leader>cw" = {
          #   action = "workspace_symbol";
          #   desc = "Workspace Symbol";
          # };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        # diagnostic = {
        #   "<leader>cd" = {
        #     action = "open_float";
        #     desc = "Line Diagnostics";
        #   };
        #   "[d" = {
        #     action = "goto_next";
        #     desc = "Next Diagnostic";
        #   };
        #   "]d" = {
        #     action = "goto_prev";
        #     desc = "Previous Diagnostic";
        #   };
        # };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end;

  '';
}
