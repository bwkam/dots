{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.editors.doom-emacs;
in
{
  options.modules.editors.doom-emacs.enable = lib.mkEnableOption "doom-emacs";

  config = lib.mkIf cfg.enable {

    home.packages = with pkgs; [
      binutils # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      ((emacsPackagesFor emacsNativeComp).emacsWithPackages (epkgs: [ epkgs.vterm ]))

      ## Doom dependencies
      git
      (ripgrep.override { withPCRE2 = true; })
      gnutls # for TLS connectivity

      ## Optional dependencies
      fd # faster projectile indexing
      imagemagick # for image-dired
      pinentry-emacs # in-emacs gnupg prompts
      zstd # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (
        ds: with ds; [
          en
          en-computers
          en-science
        ]
      ))
      # :tools editorconfig
      editorconfig-core-c # per-project style confiig
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
      # unstable.fava # HACK Momentarily broken on nixos-unstable
    ];

    home.sessionPath = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    home.activation.installDoomEmacs = ''
      if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
         ${pkgs.git}/bin/git clone --depth=1 --single-branch https://github.com/doomemacs/doomemacs "$XDG_CONFIG_HOME/emacs"
         ${pkgs.git}/bin/git clone https://github.com/doomemacs/doomemacs  "$XDG_CONFIG_HOME/doom"
      fi
    '';

    # moddules.eshell.zsh.rcFiles = [ "${configDir}/emacs/aliases.zsh" ];

    # fonts = [ pkgs.emacs-all-the-icons-fonts ];
  };
}
