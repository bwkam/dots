{
  pkgs,
  config,
  lib,
  ...
}:

let
  cfg = config.modules.desktop.gtk;
in
{
  options.modules.desktop.gtk.enable = lib.mkEnableOption "Enable gtk";
  config = lib.mkIf cfg.enable {

    home = {

      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };

      sessionVariables = {
        GTK_USE_PORTAL = "1";
      };
    };

    gtk = {
      enable = true;

      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk2.extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };
  };
}
