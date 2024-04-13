{ config, lib, pkgs, ... }:

let cfg = config.options.modules.misc.starship;
in {
  options.modules.misc.starship = lib.mkEnableOption "starship";
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings = {

      };
    };
  };
}
