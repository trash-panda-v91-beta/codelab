{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    cowsay
    fortune
    lolcat
  ];

  plugins.snacks = {
    settings = {
      dashboard = {
        enabled = true;
        example = "startify";
        sections = [
          {
            section = "terminal";
            cmd = "fortune -s | cowsay | lolcat";
            padding = 1;
            indent = 8;
          }
          {
            icon = " ";
            title = "Projects";
            section = "projects";
            indent = 2;
            padding = 1;
          }
          {
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            indent = 2;
            padding = 1;
          }
        ];
      };
    };
  };
  keymaps = [
  ];
}
