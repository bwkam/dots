{ pkgs, lib, config, ... }:

let cfg = config.modules.misc.picom;

in {

  options.modules.misc.picom.enable = lib.mkEnableOption "Enable picom";
  config = lib.mkIf cfg.enable {

    services.picom = {
      enable = true;
      # package = pkgs.callPackage ./ib-picom.nix { };
      package = pkgs.picom-next;
      #package = pkgs.picom-jonaburg;
      backend = "glx";
      vSync = true;

      settings = {
        shadow = false;

        dithered-present = false;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;

        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        glx-no-stencil = true;
        use-damage = true;

        inactive-opacity = 1.0;
        active-opacity = 1.0;
        inactive-opacity-override = false;

        focus-exclude = [ "class_g = 'Cairo-clock'" "class_g = 'slop'" ];

        opacity-rule = [
          "100:class_g = 'Alacritty'"
          "100:class_g = 'FloaTerm'"
          "95:class_g = 'Updating'"
          "90:class_g = 'scratch'"
        ];

        corner-radius = 6;

        rounded-corners-exclude = [
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'popup'"
          "window_type = 'dock'"
          "class_g = 'Polybar'"
          "class_g = 'eww-bar'"
          "class_g = 'Viewnior'"
          "class_g = 'Rofi'"
          "class_g = 'mpv'"
          "class_g = 'retroarch'"
        ];

        shadow-exclude = [
          "name = 'Notification'"
          "class_g = 'Conky'"
          "class_g ?= 'Notify-osd'"
          "class_g = 'Cairo-clock'"
          "class_g = 'slop'"
          "class_g = 'scratch'"
          "class_g = 'retroarch'"
          "class_g = 'Rofi'"
          #"class_g = 'Polybar'"
          "_GTK_FRAME_EXTENTS@:c"
          "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        ];

        wintypes = {
          dock = {
            fade = false;
            shadow = false;
            full-shadow = false;
          };
          popup_menu = {
            opacity = 1.0;
            shadow = false;
            full-shadow = false;
            focus = false;
          };
          dropdown_menu = { opacity = 1.0; };
        };

      };
    };

  };
}
