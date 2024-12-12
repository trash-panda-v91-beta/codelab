{
  plugins.lint = {
    enable = true;
    lintersByFt = {
      python = [ "mypy" ];
      sh = [ "shellcheck" ];
      gh-actions = [ "actionlint" ];
      cfn = [ "cfn-lint" ];
    };
    linters = {
      actionlint = {
        args = [
          "-ignore"
          ''label ".+pl-linux-runner" is unknown''
          "-format"
          "{{ json .}}"
          "-"
        ];
      };
    };
  };
}
