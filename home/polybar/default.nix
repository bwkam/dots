{
  config,
  lib,
  pkgs,
  ...
}: let
  mypolybar = pkgs.polybar.override {
    # Extra packages to run polybar (mostly sound atm)
    alsaSupport = true;
    pulseSupport = true;
  };

  config = builtins.readFile ./config.ini;
in {
  services = {
    polybar = {
      enable = true;
      script = ''
        polybar -q emi-bar -c /home/bwkam/dots/home/polybar/config.ini &
      ''; # Gets fixed in the bspwmrc file
      package = mypolybar;
      extraConfig = config;
    };
  };
}
