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
        actionlint.enable = true;
        cfn_lint.enable = true;
        statix.enable = true;
        yamllint.enable = true;
      };
      formatting = {
        nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
        stylua.enable = true;
        yamlfmt = {
          enable = true;
        };
        hclfmt.enable = true;
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
