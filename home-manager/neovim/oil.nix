{ pkgs, ... }: {
  plugins.oil = { enable = true; };

  plugins.oil.columns.icon = { enable = true; };
  extraPlugins = with pkgs.vimPlugins; [ nvim-web-devicons ];

  maps = {
    normal = {
      "<leader>_" = {
        action = "<cmd>Oil<CR>";
        silent = true;
      };
    };
  };
}

