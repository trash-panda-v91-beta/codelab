{
  plugins.codecompanion = {
    enable = true;
    settings = {
      display = {
        enabled = true;
        diff = {
          provider = "mini_diff";
        };
      };
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
