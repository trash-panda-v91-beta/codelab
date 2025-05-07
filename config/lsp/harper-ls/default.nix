{
  lsp.servers.harper_ls = {
    enable = true;
    settings.settings = {
      "harper-ls" = {
        linters = {
          boring_words = true;
          linking_verbs = true;
          sentence_capitalization = false;
        };
        codeActions = {
          forceStable = true;
        };
      };
    };
  };
}
