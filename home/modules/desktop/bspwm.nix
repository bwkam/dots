{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.desktop.bspwm;
in {
  options.modules.desktop.bspwm.enable = lib.mkEnableOption "bspwm";

  # bspwm
  config = lib.mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + space" = "dmenu_run";
        "super + {1-5, 0}" = "bspc desktop -f '^{1-5}'";
        "super + w" = "bspc node -c";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + alt + {q, r}" = "bspc {quit,wm -r}";
        "super + m" = "bspc desktop -l next";
        "super + r" = "rofi -i -show drun -modi drun -show-icons";
        "super + g" = "bspc node -s biggest.window";
        "super + l" = "betterlockscreen -l dim";
        "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
        "super + {_,shift + }{1-5,0}" = "bspc {desktop -f,node -d} '^{1-5}'";
        "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        "super + z" = "feh --bg-scale --randomize /etc/nixos/home-manager/wallpapers";
        "Print" = "flameshot gui";
        "XF86AudioNext" = "playerctl next";
        "XF86AudioPause" = "playerctl play-pause";
        "XF86AudioPlay" = "playerctl play-pause";
        "XF86AudioPrev" = "playerctl previous";
        "XF86AudioRaiseVolume" = "pactl -- set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "pactl -- set-sink-volume 0 -5%";
        "XF86AudioMute" = "pactl -- set-sink-volume 0 0%";
      };
    };

    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
        extraConfig = ''
                #! /bin/sh

          bspc monitor -d 1 2 3 4 5

          bspc config border_width 0

          bspc config window_gap     8

          bspc config right_padding 27
          bspc config left_padding  27

          bspc config split_ratio          0.52
          bspc config borderless_monocle   true
          bspc config gapless_monocle      true
          bspc config focus_follows_pointer true

          systemctl --user restart polybar.service
          feh --bg-scale /etc/nixos/home-manager/wallpapers/dark-cat-rosewater.png &

        '';
      };
    };
  };
}
