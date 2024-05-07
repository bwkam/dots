{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.hyprland;
in
{
  options.modules.desktop.hyprland.enable = lib.mkEnableOption "hyprland";

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
    };
  };
}
