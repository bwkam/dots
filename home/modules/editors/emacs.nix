{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs.enable = lib.mkEnableOption "emacs";

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      # package = pkgs.emacs29-pgtk;
    };
  };
}
