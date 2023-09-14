{
  plugins.trouble = {
    enable = true;
  };

  maps = {
    normal = {
      "<leader>t" = {
        desc = "  Trouble";
      };
      "<leader>tt" = {
        desc = "Trouble Toggle";
        action = "<cmd>TroubleToggle<CR>";
        silent = true;
      };

      "<leader>tw" = {
        desc = "Workspace Diagnostics";
        action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
        silent = true;
      };

      "<leader>tq" = {
        desc = "Quickfix";
        action = "<cmd>TroubleToggle quickfix<CR>";
        silent = true;
      };

      "gR" = {
        desc = "Lsp References";
        action = "<cmd>TroubleToggle lsp_references<CR>";
        silent = true;
      };
    };
  };
}
