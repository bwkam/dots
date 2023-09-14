{
  plugins.null-ls = {
    enable = true;
    sources = {
      code_actions = {
        statix.enable = true;
        eslint_d.enable = true;
        shellcheck.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        flake8.enable = true;
        shellcheck.enable = true;
      };

      formatting = {
        alejandra.enable = true;
        black.enable = true;
        isort.enable = true;
        shfmt.enable = true;
      };
    };
  };

}
