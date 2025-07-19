{
  config,
  lib,
  pkgs,
  ...
}:
let
  treesitter-kulala-http-grammar = pkgs.tree-sitter.buildGrammar {
    language = "kulala_http";
    version = "5.3.1";
    src = pkgs.fetchFromGitHub {
      owner = "mistweaverco";
      repo = "kulala.nvim";
      rev = "902fc21e8a3fee7ccace37784879327baa6d1ece";
      hash = "sha256-whQpwZMEvD62lgCrnNryrEvfSwLJJ+IqVCywTq78Vf8=";
    };
    location = "lua/tree-sitter";
  };
in
{
  plugins = {
    kulala = {
      enable = true;
      settings = {
        global_keymaps = true;
        global_keymaps_prefix = "<leader>h";
        kulala_keymaps_prefix = "";
        ui = {
          split_direction = "horizontal";
        };
      };
    };
    treesitter = lib.mkIf config.plugins.kulala.enable {
      grammarPackages = [ treesitter-kulala-http-grammar ];
      luaConfig.post = # lua
        ''
          do
          	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
          	parser_config.kulala_http = {
          		install_info = {
          			url = "${treesitter-kulala-http-grammar}",
          			files = { "src/parser.c" },
          		},
          		filetype = "kulala_http",
          	}
          end
        '';
    };
  };

  keymaps = lib.mkIf config.plugins.kulala.enable [
  ];
}
