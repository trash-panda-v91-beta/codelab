{
  plugins = {
    render-markdown = {
      enable = true;
      lazyLoad.settings.ft = [
        "markdown"
        "codecompanion"
      ];
      settings = {
        render_modes = true;
        file_types = [
          "markdown"
          "codecompanion"
        ];
      };
    };
  };
}
