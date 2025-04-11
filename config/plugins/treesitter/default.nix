{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;

    settings = {
      indent = {
        enable = true;
      };
      highlight = {
        enable = true;
      };
    };

    folding = true;
    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };
  extraFiles = {
    "queries/python/injections.scm".text = ''
      ; extends

      ((comment)  @_comment
        (#eq? @_comment "# sql")
        .
        (expression_statement
          (assignment
            right: (string
                (string_content)  @injection.content
            ))
          )
          (#set! injection.language "sql")
      )
    '';

  };
}
