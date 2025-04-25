{
  plugins.treesitter-textobjects = {
    enable = true;
    select = {
      enable = true;
      lookahead = true;
      keymaps = {
        "aa" = "@parameter.outer";
        "ia" = "@parameter.inner";
        "af" = "@function.outer";
        "if" = "@function.inner";
        "ac" = "@class.outer";
        "ic" = "@class.inner";
        "io" = "@conditional.inner";
        "ao" = "@conditional.outer";
        "il" = "@loop.inner";
        "al" = "@loop.outer";
        "at" = "@comment.outer";
      };
    };
    move = {
      enable = true;
      gotoNextStart = {
        "]f" = "@function.outer";
        "]]" = "@class.outer";
      };
      gotoNextEnd = {
        "]F" = "@function.outer";
        "][" = "@class.outer";
      };
      gotoPreviousStart = {
        "[f" = "@function.outer";
        "[[" = "@class.outer";
      };
      gotoPreviousEnd = {
        "[F" = "@function.outer";
        "[]" = "@class.outer";
      };
    };
    swap = {
      enable = true;
      swapNext = {
        "<leader>a" = "@parameters.inner";
      };
      swapPrevious = {
        "<leader>A" = "@parameter.outer";
      };
    };
    lspInterop = {
      enable = true;
      border = "single";
      peekDefinitionCode = {
        "<leader>df" = {
          query = "@function.outer";
          desc = "Peek definition outer function";
        };
        "<leader>dF" = {
          query = "@class.outer";
          desc = "Peek definition outer class";
        };
      };
    };
  };
}
