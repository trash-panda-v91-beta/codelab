{ config, lib, ... }:
{
  extraFiles = {
    "snippets/markdown.json".source = ./snippets/markdown.json;
  };
  plugins.mini.modules.snippets = {
    snippets = {
      __unkeyed-1.__raw = lib.mkIf config.plugins.friendly-snippets.enable ''
        require("mini.snippets").gen_loader.from_file("${config.plugins.friendly-snippets.package}/snippets/global.json")
      '';
      __unkeyed-2.__raw = ''
        require("mini.snippets").gen_loader.from_lang()
      '';
    };
  };
}
