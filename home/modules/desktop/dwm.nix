{ config, pkgs, lib, inputs, ... }:
let cfg = config.modules.desktop.dwm;
in {
  options.modules.desktop.dwm.enable = lib.mkEnableOption "dwm";

  # dwm
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ (inputs.dwm) st dmenu xclip ];
    services.polybar.enable = lib.mkForce false;
    services.picom.enable = lib.mkForce false;
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + space" = "dmenu_run";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + r" = "rofi -i -show drun -modi drun -show-icons";
        "space + l" = "betterlockscreen -l dim";
        # "super + z" = "${shuffleWal}/bin/shuffleWal";
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
      windowManager.command =
        "${lib.getExe inputs.dwm.packages.x86_64-linux.default}";
      numlock.enable = true;
    };
  };
}
