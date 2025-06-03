{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "Inlayhint-filler";
      src = pkgs.fetchFromGitHub {
        owner = "Davidyz";
        repo = "inlayhint-filler.nvim";
        rev = "1c89bc6405831c01a6b2cdea0a8f8f344d147ea8";
        hash = "sha256-y/faRX2/o6ipPma599Lfn3zefJAKWqTXc30dU9hLf18=";
      };
    })
  ];
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ch";
      action.__raw = ''
        function()
            require("inlayhint-filler").fill()
        end
      '';
      options = {
        desc = "Insert the inlay-hint under cursor into the buffer.";
      };
    }
  ];
}
