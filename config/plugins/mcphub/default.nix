{ inputs, system, ... }:
let
  mcphub-nvim = inputs.mcphub-nvim.packages.${system}.default;
  mcp-hub = inputs.mcp-hub.packages.${system}.default;
in
{
  extraPackages = [
    mcp-hub
  ];
  extraPlugins = [
    mcphub-nvim
  ];
  extraConfigLua = ''
    require("mcphub").setup({
    	auto_approve = true,
    })
  '';

  plugins.codecompanion = {
    settings = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion";
          opts = {
            show_result_in_chat = true; # Show the mcp tool result in the chat buffer
            make_vars = true; # make chat #variables from MCP server resources
            make_slash_commands = true; # make /slash_commands from MCP server prompts
          };
        };
      };
    };
  };

}
