{ pkgs, ... }:
{
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    settings = {
      updateInInsert = false;
    };
    sources = {
      code_actions = {
        # gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        yamllint.enable = true;
      };
      formatting = {
        nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          settings = ''
            {
              extra_args = { "--no-semi" },
            }
          '';
        };
        stylua.enable = true;
        yamlfmt = {
          enable = false;
        };
      };
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
