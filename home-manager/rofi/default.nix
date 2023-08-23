{ config, pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = "rounded-pink-dark";
    font = "Iosevka";
  };

  home.file.".config/rofi/themes" = {
    source = ./themes;
    recursive = true;
  };

}
