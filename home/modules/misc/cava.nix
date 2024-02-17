{ config, lib, pkgs, ... }:

let cfg = config.modules.misc.cava;
in {
  options.modules.misc.cava.enable = lib.mkEnableOption "cava";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.cava ];
    xdg.configFile."cava/config".text = ''
      # cava config
      [color]

      gradient = 1

      gradient_color_1 = '#94e2d5'
      gradient_color_2 = '#89dceb'
      gradient_color_3 = '#74c7ec'
      gradient_color_4 = '#89b4fa'
      gradient_color_5 = '#cba6f7'
      gradient_color_6 = '#f5c2e7'
      gradient_color_7 = '#eba0ac'
      gradient_color_8 = '#f38ba8'
    '';

  };
}
