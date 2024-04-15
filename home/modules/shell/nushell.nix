{ config, lib, pkgs, ... }:
let cfg = config.modules.shell.nushell;
in {
  options.modules.shell.nushell.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf cfg.enable {
    programs.nushell = {

      enable = true;

      shellAliases = with pkgs; {
        ".." = "cd ..";
        cat = "${bat}/bin/bat";
        ls = "${eza}/bin/eza --group-directories-first --git --icons";
        ytmp3 = "yt-dlp --extract-audio --audio-format mp3";
        haxe_language_server = "node $HOME/haxe-language-server/bin/server.js";
        v = "nvim";
      };

    };
  };

}
