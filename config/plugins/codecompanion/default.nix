{
  plugins.codecompanion = {
    enable = true;
    settings = {
      display = {
        enabled = true;
        diff = {
          provider = "mini_diff";
        };
        chat = {
          window = {
            layout = "horizontal";
            height = 0.5;
          };
        };
      };
      strategies = {
        agent = {
          adapter = "copilot";
        };
        chat = {
          adapter = "copilot";
          keymaps = {
            send = {
              modes = {
                n = "<A-s>";
                i = "<A-s>";
              };
            };
          };
        };
        inline = {
          adapter = "copilot";
        };
      };
    };
  };
  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<A-c>";
      action = "<cmd>CodeCompanionChat Toggle<CR>";
      options = {
        desc = "Trigger CodeCompanion chat";
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<A-i>";
      action = "<cmd>CodeCompanion<CR>";
      options = {
        desc = "Trigger CodeCompanion inline";
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<localleader>aa";
      action = "<cmd>CodeCompanionActions<CR>";
      options = {
        desc = "Trigger CodeCompanion actions";
        silent = true;
      };
    }
  ];
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
