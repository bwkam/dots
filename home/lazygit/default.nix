{ config, lib, pkgs } : {
  home.packages =  with pkgs;[lazygit];
  xdg.configFile = {
    "lazygit/config.yml".source = ./config.yml;
  };
}
