{ pkgs, lib, config, inputs, ... }:

let cfg = config.modules.misc.wallust;

in {
  options.modules.misc.wallust.enable = lib.mkEnableOption "enable wallust";

  config = lib.mkIf cfg.enable {
    home.packages =
      [ (inputs.nixpkgs-unstable.legacyPackages."x86_64-linux".wallust) ];

    home.file.".config/wallust/templates" = {
      source = ./templates;
      recursive = true;
    };

    home.file.".config/wallust/wallust.toml".text = ''
      backend = "fastresize"
      color_space = "labfast"
      threshold = 20
      filter = "dark16"

      [[entry]]
      template = "templates/colors"
      target = "~/.cache/wal/colors"

      [[entry]]
      template = "templates/colors.css"
      target = "~/.cache/wal/colors.css"

      [[entry]]
      template = "templates/colors.json"
      target = "~/.cache/wal/colors.json"

      [[entry]]
      template = "templates/colors.lua"
      target = "~/.cache/wal/colors.lua"

      [[entry]]
      template = "templates/colors.ron"
      target = "~/.cache/wal/colors.ron"

      [[entry]]
      template = "templates/colors.scss"
      target = "~/.cache/wal/colors.scss"

      [[entry]]
      template = "templates/colors.fish"
      target = "~/.cache/wal/colors.fish"

      [[entry]]
      template = "templates/colors.toml"
      target = "~/.cache/wal/colors.toml"

      [[entry]]
      template = "templates/colors.yaml"
      target = "~/.cache/wal/colors.yaml"

      [[entry]]
      template = "templates/gtk.css"
      target = "~/.cache/wal/gtk.css"

      [[entry]]
      template = "templates/kitty.conf"
      target = "~/.cache/wal/kitty.conf"

      [[entry]]
      template = "templates/tty.sh"
      target = "~/.cache/wal/tty.sh"

    '';

    programs.fish.shellInit = ''
      if test -e ~/.cache/wal/colors.fish
          source ~/.cache/wal/colors.fish
      end
    '';

    programs.kitty.extraConfig = ''
      include ~/.cache/wal/kitty.conf
    '';

  };

}
