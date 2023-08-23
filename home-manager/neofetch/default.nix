{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.neofetch ];
  home.file.".config/neofetch/config.conf".source = ./config.conf;
  home.file.".config/neofetch/logo.svg".source = ./logo.svg;
}
