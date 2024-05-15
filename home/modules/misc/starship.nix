{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.misc.starship;
in {
  options.modules.misc.starship.enable = lib.mkEnableOption "starship";
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings = {
      };
    };
  };
}
