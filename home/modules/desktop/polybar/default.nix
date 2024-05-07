{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.polybar;

  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    pulseSupport = true;
  };

  polybarConfig = builtins.readFile ./config.ini;
in
{
  options.modules.desktop.polybar.enable = lib.mkEnableOption "Polybar";
  config = lib.mkIf cfg.enable {
    services = {
      polybar = {
        enable = true;
        script = ''
          polybar &
        ''; # Gets fixed in the bspwmrc file
        package = mypolybar;
        extraConfig = polybarConfig;
      };
    };
  };
}
