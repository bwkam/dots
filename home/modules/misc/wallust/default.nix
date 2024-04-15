{ pkgs, lib, config, ... }:

let cfg = config.modules.misc.wallust;

in {
  options.modules.misc.wallust.enable = lib.mkEnableOption "enable wallust";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wallust ];

    home.file.".config/wallust/templates" = {
      source = ./templates;
      recursive = true;
    };

    home.file.".config/wallust/wallust.toml".text = ''
      backend = "full"
      color_space = "lab"
      palette = "harddark16"

      [templates]
      dir.template = "templates/"
      dir.target = "~/.cache/wal/"
      dir.pywal = true
    '';

    programs.kitty.extraConfig = ''
      include ~/.cache/wal/kitty.conf
    '';

    services.polybar.extraConfig = ''
      include-file = ~/.cache/wal/colors.ini
    '';

  };

}
