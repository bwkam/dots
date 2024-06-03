{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/desktop
    ./modules/editors
    ./modules/shell
    ./modules/dev
    ./modules/misc
    ./modules/terminal
    ./modules/browsers
  ];

  modules = {
    editors = {
      nvim.enable = true;
      code.enable = false;
    };

    desktop = {
      bspwm.enable = false;
      dwm.enable = true;
      hyprland.enable = false;
      gtk.enable = true;
      rofi.enable = false;
      polybar.enable = true;
    };

    browsers = {
      firefox.enable = true;
    };

    # dev = { lazygit.enable = true; };

    terminal = {
      kitty.enable = true;
    };

    misc = {
      neofetch.enable = true;
      zathura.enable = true;
      xdg.enable = true;
      starship.enable = true;
      picom.enable = false;
    };

    shell = {
      fish.enable = true;
    };
  };

  home.username = "bwkam";
  home.homeDirectory = "/home/bwkam";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changingr

  home.packages = with pkgs; [
    # cli
    sops
    pandoc
    haxe
    sad
    nurl
    ranger
    zellij
    (xcompmgr.overrideAttrs (final: prev: {
      src = fetchFromGitHub {
        owner = "tycho-kirchner";
        repo = "fastcompmgr";
        rev = "1b158ec2bab7298b7225526fbbd558650e0e3741";
        hash = "sha256-AqTacBmFK4KnQmbGq94E3SNZlxKkC6o3szF+Fpa5dgk=";
      };
    }))
    (weechat.override {
      configure = {...}: {
        scripts = with pkgs.weechatScripts; [
          (weechat-matrix.overrideAttrs (
            final: prev: {
              postFixup =
                prev.postFixup
                + ''
                  substituteInPlace $out/lib/python3.11/site-packages/matrix/uploads.py --replace \"matrix_upload\" \"$out/bin/matrix_upload\"
                '';
            }
          ))
        ];
      };
    })
    translate-shell
    steam-run
    typst
    typst-preview
    youtube-tui
    fzf
    cmatrix
    mlterm
    htop
    eza
    gh
    (inputs.ghostty.packages.x86_64-linux.default)
    gnumeric
    ripgrep
    xorg.xkill
    xsel
    xdotool
    playerctl
    # steam-run
    yt-dlp
    cachix
    wine
    unzip
    zip
    openssl

    networkmanagerapplet
    gparted
    google-chrome
    rhythmbox
    tracker
    mpv
    tracker-miners
    hplip
    pavucontrol
    flameshot
    feh
    obs-studio
    simplescreenrecorder
    peek
    audacity
    gnome.simple-scan
    gnome.cheese

    material-icons
    material-design-icons
    roboto
    work-sans
    comic-neue
    source-sans
    twemoji-color-font
    comfortaa
    inter
    lato
    lexend
    jost
    dejavu_fonts
    iosevka-bin
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
    font-awesome_5

    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "JetBrainsMono"
        "Meslo"
      ];
    })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # ''; 11
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    playerctld.enable = true;
    betterlockscreen.enable = true;
    # dunst.enable = true;

    gnome-keyring.enable = true;
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  # nix.package = pkgs.nix;

  # dconf
  dconf.enable = true;

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "bwkam";
    userEmail = "beshoykamel391@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
