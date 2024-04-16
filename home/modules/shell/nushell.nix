{ config, lib, pkgs, ... }:
let cfg = config.modules.shell.nushell;
in {
  options.modules.shell.nushell.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf cfg.enable {
    programs.nushell = {

      enable = true;

      extraConfig = ''
        $env.config = {
          show_banner: false,
          color_config: $base16_theme 
          completions: {
            algorithm: "fuzzy"
          }
        }
      '';

      shellAliases = with pkgs; {
        ".." = "cd ..";
        cat = "${bat}/bin/bat";
        ytmp3 = "yt-dlp --extract-audio --audio-format mp3";
        v = "nvim";
      };

    };
  };

}
