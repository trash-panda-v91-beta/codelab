{ lib, pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.nvim-sops ];
  extraConfigLua = ''
    require("nvim_sops").setup({
    	binPath = "${lib.getExe pkgs.sops}",
    })
  '';
  keymaps = [
    {
      mode = [
        "n"
      ];
      key = "<leader>se";
      action = "<cmd>SopsEncrypt<CR>";
      options = {
        desc = "Encrypt file with SOPS";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>sd";
      action = "<cmd>SopsDecrypt<CR>";
      options = {
        desc = "Decrypt file with SOPS";
      };
    }
  ];
}
