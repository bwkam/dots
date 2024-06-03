{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.desktop.dwm;
in {
  options.modules.desktop.dwm.enable = lib.mkEnableOption "dwm";

  # dwm
  config = lib.mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit (inputs.suckless.packages.x86_64-linux) dwm dwmblocks;
      inherit (pkgs) xclip dmenu;
    };

    systemd.user.services.dwmblocks = {
      Unit = {
        Description = "Status feed generator for dwm";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };

      Service = {
        Restart = "always";
        ExecStart = lib.getExe inputs.suckless.packages.${pkgs.system}.dwmblocks;
      };
    };

    services.polybar.enable = lib.mkForce false;
    # services.picom.enable = lib.mkForce false;

    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "kitty";
        "super + space" = "dmenu_run";
        "super + Escape" = "pkill -USR1 -x sxhkd";
        "super + r" = "rofi -i -show drun -modi drun -show-icons";
        "alt + l" = "betterlockscreen -l dim";
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
      windowManager.command = "${lib.getExe inputs.suckless.packages.x86_64-linux.dwm}";
      numlock.enable = true;
    };
  };
}
