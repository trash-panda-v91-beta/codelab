{
  plugins = {
    render-markdown = {
      enable = true;
      lazyLoad.settings.ft = [
        "markdown"
        "codecompanion"
      ];
      settings = {
        completions = {
          lsp = {
            enabled = true;
          };
        };
        file_types = [
          "markdown"
          "codecompanion"
        ];
        render_modes = true;
      };
    };
  };
}
