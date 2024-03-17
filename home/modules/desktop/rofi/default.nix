{ config, pkgs, lib, ... }:

let cfg = config.modules.desktop.rofi;
in {

  options.modules.desktop.rofi.enable = lib.mkEnableOption "Enable rofi";
  config = lib.mkIf cfg.enable {

    programs.rofi = {
      enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      # theme = "rounded-pink-dark";
      font = "Iosevka";
    };

    home.file.".config/rofi/themes" = {
      source = ./themes;
      recursive = true;
    };
  };

}
