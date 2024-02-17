{ config, lib, pkgs, ... }:

let cfg = config.modules.misc.xdg;

in {
  options.modules.misc.xdg.enable = lib.mkEnableOption "xdg";
  config = lib.mkIf cfg.enable {

    xdg = {
      enable = true;
      mime.enable = true;
      userDirs.enable = true;
      userDirs.createDirectories = true;
    };

  };

}
