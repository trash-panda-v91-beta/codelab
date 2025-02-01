{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    shfmt
    yamlfmt
  ];
  plugins.conform-nvim = {
    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWrite" ];
    };
    enable = true;
    settings = {

      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notify_on_error = true;

      formatters_by_ft = {
        bash = [
          "shfmt"
        ];
        liquidsoap = [ "liquidsoap-prettier" ];
        html = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        css = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        javascriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescript = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        typescriptreact = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        python = [
          "ruff_format"
          "ruff_fix"
          "ruff_organize_imports"
        ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        markdown = [
          [
            "prettierd"
            "prettier"
          ]
        ];
        yaml = [
          "yamlfmt"
        ];
        terragrunt = [
          "hcl"
        ];
        sh = [
          "shfmt"
        ];
      };
    };
  };
}
