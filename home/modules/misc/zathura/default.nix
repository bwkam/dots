{ pkgs, config, lib, ... }:

let cfg = config.modules.misc.zathura;

in {

  options.modules.misc.zathura.enable = lib.mkEnableOption "Enable zathura";

  config = lib.mkIf cfg.enable {

    programs.zathura = { enable = true; };

    xdg.configFile."zathura/zathurarc" = {
      text = ''
        include catppuccin-mocha
      '';
    };

    xdg.configFile."zathura/catppuccin-mocha" = {
      source = ./catppuccin-mocha;
    };

  };
}
