{
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    lint = {
      enable = true;

      lazyLoad.settings.event = "DeferredUIEnter";

      lintersByFt = {
        bash = [ "shellcheck" ];
        cfn = [ "cfn-lint" ];
        fish = [ "fish" ];
        gh-actions = [ "actionlint" ];
        go = [ "golangcilint" ];
        json = [ "jsonlint" ];
        lua = [ "luacheck" ];
        markdown = [ "markdownlint" ];
        nix = [
          "deadnix"
          "nix"
          "statix"
        ];
        python = [
          "ruff"
        ];
        sh = [ "shellcheck" ];
        terraform = [ "tflint" ];
        yaml = [ "yamllint" ];
      };

      linters = {
        checkmake = {
          cmd = lib.getExe pkgs.checkmake;
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
        jsonlint = {
          cmd = lib.getExe pkgs.nodePackages.jsonlint;
        };
        luacheck = {
          cmd = lib.getExe pkgs.luaPackages.luacheck;
        };
        markdownlint = {
          cmd = lib.getExe pkgs.markdownlint-cli;
        };
        ruff = {
          cmd = lib.getExe pkgs.ruff;
        };
        shellcheck = {
          cmd = lib.getExe pkgs.shellcheck;
        };
        cfn_lint = {
          cmd = lib.getExe pkgs.python311Packages.cfn-lint;
        };
        actionlint = {
          cmd = lib.getExe pkgs.actionlint;
        };
        sqlfluff = {
          cmd = lib.getExe pkgs.sqlfluff;
        };
        statix = {
          cmd = lib.getExe pkgs.statix;
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
