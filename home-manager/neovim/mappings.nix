{
  maps = {
    normal = {
      "<leader>g" = {
        desc = "  Git";
      };

      "<leader>l" = {
        desc = "  Lsp";
      };

      "<leader>w" = {
        desc = "Save";
        action = "<cmd>w<CR>";
        silent = true;
      };

      "<leader>q" = {
        desc = "Quit";
        action = "<cmd>q<CR>";
        silent = true;
      };
    };
    visual = {
      ">" = ">gv";
      "<" = "<gv";
    };
  };

}
