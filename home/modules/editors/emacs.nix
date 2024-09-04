{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs.enable = lib.mkEnableOption "emacs";

  config = lib.mkIf cfg.enable {
    services.emacs.enable = true;

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
      extraPackages = epkgs: [epkgs.vterm];
    };

    home.packages = with pkgs; [
      ## Doom dependencies
      git
      binutils
      coreutils
      ripgrep
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      zstd # for undo-fu-session/undo-tree compression

      # :tools editorconfig
      editorconfig-core-c # per-project style confiig
    ];

    home.sessionPath = ["$XDG_CONFIG_HOME/emacs.d/bin"];
  };
}
