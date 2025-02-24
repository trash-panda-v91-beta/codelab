{
  plugins.codecompanion = {
    enable = true;
    settings = {
      strategies = {
        agent = {
          adapter = "copilot";
        };
        chat = {
          adapter = "copilot";
        };
        inline = {
          adapter = "copilot";
        };
      };
    };
  };
  plugins.render-markdown = {
    enable = true;
    lazyLoad.settings = {
      ft = [ "codecompanion" ];
    };
    settings = {
      file_types = [
        "codecompanion"
      ];
    };
  };
}
