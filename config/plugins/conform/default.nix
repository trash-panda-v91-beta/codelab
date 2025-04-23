{
  config,
  lib,
  pkgs,
  ...
}:
{
  plugins.conform-nvim = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "ConformInfo"
      ];
      event = [ "BufWritePre" ];
    };
    luaConfig.pre = ''
      local slow_format_filetypes = {}
    '';
    settings = {
      default_format_opts = {
        lsp_format = "fallback";
      };
      format_on_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

             -- Disable autoformat for slow filetypes
            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

             -- Disable autoformat for files in a certain path
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if bufname:match("/node_modules/") or bufname:match("/.direnv/") then
              return
            end

            local function on_format(err)
              if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
              end
            end

            return { timeout_ms = 200, lsp_fallback = true }, on_format
           end
        '';
      format_after_save = # Lua
        ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return 
            end 
            return { lsp_fallback = true }
          end
        '';
      formatters_by_ft = {
        bash = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        css = [ "stylelint" ];
        fish = [ "fish_indent" ];
        javascript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "biome";
          timeout_ms = 2000;
          stop_after_first = true;
        };
        json = [ "jq" ];
        html = [ "prettierd" ];
        lua = [ "stylua" ];
        nix = [
          "nixfmt"
          "injected"
        ];
        python = [
          "ruff_fix"
          "ruff_format"
          "ruff_organize_imports"
          "injected"
        ];
        sql = [ "sqlfluff" ];
        rust = [ "rustfmt" ];
        sh = [
          "shellcheck"
          "shellharden"
          "shfmt"
        ];
        swift = [ "swift_format" ];
        toml = [ "taplo" ];
        typescript = {
          __unkeyed-1 = "prettierd";
          __unkeyed-2 = "biome";
          timeout_ms = 2000;
          stop_after_first = true;
        };
        xml = [
          "xmlformat"
          "xmllint"
        ];
        yaml = [ "yamlfmt" ];
      };
      formatters = {
        biome = {
          command = lib.getExe pkgs.biome;
          env = {
            BIOME_CONFIG_PATH = pkgs.writeTextFile {
              name = "biome.json";
              text = lib.generators.toJSON { } {
                "$schema" = "${pkgs.biome}/node_modules/@biomejs/biome/configuration_schema.json";
                formatter.useEditorconfig = true;
              };
            };
          };
        };
        jq.command = lib.getExe pkgs.jq;
        nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
        prettierd.command = lib.getExe pkgs.prettierd;
        ruff.command = lib.getExe pkgs.ruff;
        rustfmt.command = lib.getExe pkgs.rustfmt;
        shellcheck.command = lib.getExe pkgs.shellcheck;
        shellharden.command = lib.getExe pkgs.shellharden;
        shfmt.command = lib.getExe pkgs.shfmt;
        sqlfluff.command = lib.getExe pkgs.sqlfluff;
        stylelint.command = lib.getExe pkgs.stylelint;
        stylua.command = lib.getExe pkgs.stylua;
        swift_format.command = lib.getExe pkgs.swift-format;
        taplo.command = lib.getExe pkgs.taplo;
        xmlformat.command = lib.getExe pkgs.xmlformat;
        yamlfmt.command = lib.getExe pkgs.yamlfmt;
        injected = {
          ignore_errors = false;
        };
      };
    };

  };
  userCommands = lib.mkIf config.plugins.conform-nvim.enable {
    FormatDisable = {
      desc = "Disable auto formatting";
      bang = true;
      command.__raw = ''
        function(args)
          if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end
      '';
    };
    FormatEnable = {
      desc = "Enable auto formatting";
      command.__raw = ''
        function()
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end
      '';
    };
    Format = {
      desc = "Formatting using conform.nvim";
      range = true;
      command.__raw = ''
        function(args)
          ${lib.optionalString config.plugins.lz-n.enable "require('lz.n').trigger_load('conform.nvim')"}
          local range = nil
          if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, end_line:len() },
            }
          end
          require("conform").format({ async = true, lsp_format = "fallback", range = range },
          function(err)
            if not err then
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
              end
            end
          end)
        end
      '';
    };
  };
  keymaps = lib.optionals config.plugins.conform-nvim.enable [
    {
      action.__raw = ''
        function(args)
         vim.cmd({cmd = 'Format', args = args});
        end
      '';
      mode = "v";
      key = "<leader>cf";
      options = {
        silent = true;
        buffer = false;
        desc = "Format selection";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('Format');
        end
      '';
      key = "<leader>cf";
      options = {
        silent = true;
        desc = "Format buffer";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('FormatDisable');
        end
      '';
      key = "<leader>cd";
      options = {
        silent = true;
        desc = "Disable auto formatting";
      };
    }
    {
      action.__raw = ''
        function()
          vim.cmd('FormatEnable');
        end
      '';
      key = "<leader>ce";
      options = {
        silent = true;
        desc = "Enable auto formatting";
      };
    }
  ];

}
