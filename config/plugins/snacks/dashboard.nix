{ helpers, pkgs, ... }:
{
  extraPackages = with pkgs; [
    chafa
  ];

  plugins.snacks = {
    settings = {
      dashboard = {
        enabled = true;
        sections = [
          {
            title = "Recent Files";
            icon = " ";
            section = "recent_files";
            limit = 5;
            cwd = true;
            padding = 1;
            indent = 1;
          }
          {
            icon = " ";
            title = "Git Status";
            enabled.__raw = ''
              Snacks.git.get_root() ~= nil
            '';
            cmd = "git --no-pager diff --stat -B -M -C";
            section = "terminal";
            ttl = 5 * 60;
            padding = 1;
            height = 5;
            indent = 1;
          }
          {
            icon = " ";
            title = "Open PRs";
            cmd = "gh pr list -L 3";
            key = "P";
            section = "terminal";
            ttl = 5 * 60;
            padding = 1;
            height = 5;
            indent = 1;
            enabled.__raw = ''
              Snacks.git.get_root() ~= nil
            '';
            action.__raw =
              helpers.mkLuaFn # Lua
                ''
                  vim.fn.jobstart("gh pr list --web", { detach = true })
                '';
          }
          {
            icon = " ";
            desc = "Browse Repo";
            key = "b";
            action.__raw =
              helpers.mkLuaFn # Lua
                ''
                  Snacks.gitbrowse()
                '';
          }
        ];
      };
    };
  };
}
