{ config, lib, pkgs }:

let cfg = config.modules.dev.lazygit;

in {
  options.modules.dev.lazygit.enable = lib.mkEnableOption "Enable lazygit";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ lazygit ];
    xdg.configFile = { "lazygit/config.yml".source = ./config.yml; };
  };
}
