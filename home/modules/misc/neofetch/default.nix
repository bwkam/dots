{ config, lib, pkgs, ... }:

let cfg = config.modules.misc.neofetch;

in {
  options.modules.misc.neofetch.enable = lib.mkEnableOption "neofetch";

  config = lib.mkIf cfg.enable {

    home.packages = [ pkgs.neofetch ];
    home.file.".config/neofetch/config.conf".source = ./config.conf;
    home.file.".config/neofetch/logo.svg".source = ./logo.svg;

  };
}
