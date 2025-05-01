{
  projectRootFile = "flake.nix";

  programs = {
    actionlint.enable = true;
    deadnix = {
      enable = true;
    };
    fish_indent.enable = true;
    nixfmt.enable = true;
    ruff-check.enable = true;
    ruff-format.enable = true;
    rustfmt.enable = true;
    shfmt = {
      enable = true;
      indent_size = 4;
    };
    statix.enable = true;
    stylua.enable = true;
    taplo.enable = true;
    yamlfmt.enable = true;
  };

  settings = {
    global.excludes = [
      "*.editorconfig"
      "*.envrc"
      "*.gitconfig"
      "*.git-blame-ignore-revs"
      "*.gitignore"
      "*.gitattributes"
      "*.luacheckrc"
      "*CODEOWNERS"
      "*LICENSE"
      "*flake.lock"
      "justfile"
    ];

    formatter.ruff-format.options = [ "--isolated" ];
  };
}
