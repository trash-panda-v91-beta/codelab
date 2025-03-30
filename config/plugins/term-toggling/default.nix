{
  config = {
    keymaps = [
      {
        mode = [
          "n"
          "v"
          "i"
        ];
        key = "<M-t>";
        action.__raw = ''
          function()
            require("toggle-term").tmux_pane_function()
          end
        '';
        options = {
          desc = "Toggle terminal";
        };
      }
    ];
  };
}
