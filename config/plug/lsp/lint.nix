{
  lib,
  pkgs,
  config,
  ...
}:
{
  plugins = {

    lint = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      lintersByFt = {
        bash = [ "shellcheck" ];
        c = [ "clangtidy" ];
        cfn = [ "cfn-lint" ];
        css = lib.mkIf (!config.plugins.lsp.servers.stylelint_lsp.enable) [ "stylelint" ];
        fish = [ "fish" ];
        gdscript = [ "gdlint" ];
        gh-actions = [ "actionlint" ];
        go = [ "golangcilint" ];
        html = [ "htmlhint" ];
        java = [ "checkstyle" ];
        json = [ "jsonlint" ];
        lua = [ "luacheck" ];
        markdown = [ "markdownlint" ];
        nix = [
          "deadnix"
          "nix"
        ] ++ lib.optionals (!config.plugins.lsp.servers.statix.enable) [ "statix" ];
        python = [
          "mypy"
          "ruff"
        ];
        rust = [ "clippy" ];
        sh = [ "shellcheck" ];
        sql = [ "sqlfluff" ];
        terraform = [ "tflint" ];
        yaml = [ "yamllint" ];
      };

      linters = {
        actionlint = {
          cmd = lib.getExe pkgs.actionlint;
        };
        checkmake = {
          cmd = lib.getExe pkgs.checkmake;
        };
        checkstyle = {
          cmd = lib.getExe pkgs.checkstyle;
        };
        cfn_lint = {
          cmd = lib.getExe pkgs.python311Packages.cfn-lint;
        };
        clippy = {
          cmd = lib.getExe pkgs.rust-analyzer;
        };
        deadnix = {
          cmd = lib.getExe pkgs.deadnix;
        };
        fish = {
          cmd = lib.getExe pkgs.fish;
        };
        golangcilint = {
          cmd = lib.getExe pkgs.golangci-lint;
        };
        htmlhint = {
          cmd = lib.getExe pkgs.htmlhint;
        };
        jsonlint = {
          cmd = lib.getExe pkgs.nodePackages.jsonlint;
        };
        luacheck = {
          cmd = lib.getExe pkgs.luaPackages.luacheck;
        };
        markdownlint = {
          cmd = lib.getExe pkgs.markdownlint-cli;
        };
        mypy = {
          cmd = lib.getExe pkgs.mypy;
        };
        ruff = {
          cmd = lib.getExe pkgs.ruff;
        };
        shellcheck = {
          cmd = lib.getExe pkgs.shellcheck;
        };
        sqlfluff = {
          cmd = lib.getExe pkgs.sqlfluff;
        };
        statix = {
          cmd = lib.getExe pkgs.statix;
        };
        stylelint = {
          cmd = lib.getExe pkgs.stylelint;
        };
        terraform = {
          cmd = lib.getExe pkgs.tflint;
        };
        yamllint = {
          cmd = lib.getExe pkgs.yamllint;
        };
      };
    };
  };
}
