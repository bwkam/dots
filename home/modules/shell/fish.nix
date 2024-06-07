{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.shell.fish;
in {
  options.modules.shell.fish.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [fzf];
    programs.fzf = {
      enable = true;
      enableFishIntegration = false;
    };

    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        fzf_configure_bindings
      '';

      plugins = let
        apkgs = import inputs.alphapkgs {system = "x86_64-linux";};
      in [
        {
          name = "fzf-fish";
          inherit (apkgs.fishPlugins.fzf-fish) src;
        }
      ];

      shellAliases = with pkgs; {
        "sw" = "sudo nixos-rebuild switch --flake";
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
