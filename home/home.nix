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

    dev = {tmux.enable = true;};

    terminal = {
      kitty.enable = true;
    };

    misc = {
      neofetch.enable = true;
      zathura.enable = true;
      xdg.enable = true;
      starship.enable = true;
      xcompmgr.enable = false;
      mpd.enable = true;
      ncmp.enable = true;
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
  home.stateVersion = "23.05"; # Please read the comment before changing

  home.packages = with pkgs; [
    # cli
    sops
    pandoc
    sad
    nurl
    fd
    bat
    ranger
    (weechat.override {
      configure = {...}: {
        scripts = with pkgs.weechatScripts; [
          (weechat-matrix.overrideAttrs (
            _: prev: {
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
    yt-dlp
    cachix
    wine
    unzip
    zip
    openssl

    tracker
    tracker-miners
    hplip
    feh

    # gui
    flameshot
    networkmanagerapplet
    rhythmbox
    mpv
    pavucontrol
    gnome.simple-scan
    gparted
    google-chrome
    audacity
    nitrogen
    obs-studio
    simplescreenrecorder
    peek

    # fonts
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services = {
    playerctld.enable = true;
    mpdris2.enable = true;
    betterlockscreen.enable = true;
    # picom.enable = true;
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

    zoxide = {
      enable = true;
      enableFishIntegration = true;
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
