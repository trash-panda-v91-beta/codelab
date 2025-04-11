{ pkgs, ... }:
{
  plugins = {
    lsp-format = {
      enable = false;
    };
    none-ls = {
      enable = true;
      enableLspFormat = false;
      sources = {
        code_actions = {
          gitsigns.enable = true;
          refactoring.enable = true;
          statix.enable = true;
        };
        diagnostics = {
          actionlint.enable = true;
          cfn_lint.enable = true;
          checkmake.enable = true;
          codespell.enable = true;
          deadnix.enable = true;
          dotenv_linter.enable = true;
          editorconfig_checker.enable = true;
          hadolint.enable = true;
          markdownlint.enable = true;
          markdownlint_cli2.enable = true;
          sqlfluff.enable = true;
          statix.enable = true;
          todo_comments.enable = false;
          trail_space.enable = true;
          vale.enable = true;
          yamllint.enable = true;
        };
        formatting = {
          codespell.enable = true;
          markdownlint.enable = true;
          nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          stylua.enable = true;
          sqlfluff.enable = false;
          yamlfmt = {
            enable = true;
          };
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
