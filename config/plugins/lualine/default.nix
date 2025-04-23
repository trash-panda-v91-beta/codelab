{
  plugins.web-devicons.enable = true;
  plugins.lualine = {
    enable = true;
    lazyLoad.settings.event = "BufEnter";
    settings = {
      options = {
        component_separators = "";
        section_separators = {
          left = "";
          right = "";
        };
        theme = "auto";
        globalstatus = true;
        disabled_filetypes = {
          statusline = [
            "dashboard"
            "alpha"
            "starter"
            "snacks_dashboard"
          ];
        };
      };
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            fmt.__raw = ''
              function(mode)
                return mode:lower()
              end
            '';
            icon = "";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon = "";
          }
        ];
        lualine_c = [
          {
            __unkeyed = "diagnostics";
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
          }
          {
            separator = "";
            padding = {
              left = 0;
              right = 0;
            };
            __unkeyed.__raw = ''
              function()
                  local utils = require("utils")
                  local devicons = require("nvim-web-devicons")
                  local ft = vim.bo.filetype
                  local icon
                  if utils.filetype_map[ft] then
                      return " " .. utils.filetype_map[ft].icon
                  end
                  if icon == nil then
                      icon = devicons.get_icon(vim.fn.expand("%:t"))
                  end
                  if icon == nil then
                      icon = devicons.get_icon_by_filetype(ft)
                  end
                  if icon == nil then
                      icon = " 󰈤"
                  end
                  return icon .. " "
              end
            '';
            color.__raw = ''
              function()
                local utils = require("utils")
                local _, hl = require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"))
                if hl then
                    return hl
                end
                return utils.get_hlgroup("Normal")
              end
            '';
          }
          {
            __unkeyed = "filename";
            path = 4;
            file_status = false;
            padding = {
              left = 0;
              right = 0;
            };
            fmt.__raw = ''
              function(name)
                local utils = require("utils")
                if utils.filetype_map[vim.bo.filetype] then
                    return utils.filetype_map[vim.bo.filetype].name
                else
                    return name
                end
              end
            '';
          }
          {
            padding = {
              left = 0;
              right = 1;
            };
            __unkeyed.__raw = ''
              function()
                local buffer_count = require("utils").get_buffer_count()
                return "+" .. buffer_count - 1 .. " "
              end
            '';
            cond.__raw = ''
              function()
                return require("utils").get_buffer_count() > 1
              end
            '';
            color.__raw = ''require("utils").get_hlgroup("Operator", nil)'';
          }
          {
            __unkeyed.__raw = ''
              function()
                  local tab_count = vim.fn.tabpagenr("$")
                  if tab_count > 1 then
                      return vim.fn.tabpagenr() .. " of " .. tab_count
                  end
              end
            '';
            cond.__raw = ''
              function()
                  return vim.fn.tabpagenr("$") > 1
              end
            '';
            icon = "󰓩";
            color.__raw = ''require("utils").get_hlgroup("Special", nil)'';
          }
        ];
        lualine_x = [
          {
            __unkeyed.__raw = ''
              require("noice").api.status.mode.get, cond = function()
              	local ignore = {
              		"-- INSERT --",
              		"-- TERMINAL --",
              		"-- VISUAL --",
              		"-- VISUAL LINE --",
              		"-- VISUAL BLOCK --",
              	}
              	local mode = require("noice").api.status.mode.get()
              	return require("noice").api.status.mode.has() and not vim.tbl_contains(ignore, mode)
              end
            '';
            color.__raw = ''require("utils").get_hlgroup("Comment")'';
          }
          {
            __unkeyed.__raw = ''
              function()
                  local utils = require("utils")
                  local venv = utils.get_venv()
                  if venv then
                      return "● " .. venv
                  else
                    return ""
                  end
              end
            '';
            cond.__raw = ''
              function()
                return vim.bo.filetype == "python"
              end
            '';
            color.__raw = ''require("utils").get_hlgroup("Special")'';
          }
          { __unkeyed = "diff"; }
          {
            __unkeyed.__raw = ''
              function()
                if vim.b.disable_autoformat or vim.g.disable_autoformat then
                  return "F̶"
                else
                  return ""
                end
              end
            '';
            color.__raw = ''require("utils").get_hlgroup("DiagnosticWarn")'';
          }

        ];
        lualine_y = [
          {
            __unkeyed = "progress";
          }
        ];
        lualine_z = [
          {
            __unkeyed = "location";
            color.__raw = ''require("utils").get_hlgroup("Boolean")'';
          }
        ];
      };
      extensions = [
        "quickfix"
      ];
    };
  };
}
