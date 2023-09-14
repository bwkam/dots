{
  plugins.floaterm = { enable = true; };

  maps = {
    normal = {
      "<c-t>" = {
        desc = "Terminal";
        action = ":FloatermToggle<CR>";
        silent = true;
      };
    };
  };
}
