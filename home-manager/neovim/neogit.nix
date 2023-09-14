{
  plugins.neogit = {
    enable = true;
    disableCommitConfirmation = true;
  };

  maps = {
    normal = {
      "<leader>gg" = {
        desc = "Neogit";
        action = ":Neogit<CR>";
        silent = true;
      };
    };
  };
}
