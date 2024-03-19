{ pkgs, lib, config, inputs, ... }:

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
      pallete = "dark16"

      [templates]
      dir.template = "templates/"
      dir.target = "~/.cache/wal/"
      dir.pywal = true
    '';

    programs.fish.shellInit = ''
      if test -e ~/.cache/wal/colors.fish
          source ~/.cache/wal/colors.fish
      end
    '';

    programs.kitty.extraConfig = ''
      include ~/.cache/wal/kitty.conf
    '';

    services.polybar.extraConfig = ''
      include-file = ~/.cache/wal/colors.ini
    '';

  };

}
