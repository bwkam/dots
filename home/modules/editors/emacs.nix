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
      package = pkgs.emacs-unstable.override {
        withXwidgets = true;
        withGTK3 = true;
      };
      extraPackages = epkgs: with epkgs; [vterm treesit-grammars.with-all-grammars];
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
      xorg.xwininfo # for emacs-everywhere

      ## vterm
      libtool
      cmake

      ## LSP
      tinymist
      typstyle

      # :tools editorconfig
      editorconfig-core-c # per-project style confiig
    ];

    home.sessionPath = ["$XDG_CONFIG_HOME/emacs.d/bin"];
  };
}
