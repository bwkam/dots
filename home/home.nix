{
  pkgs,
  inputs,
  config,
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
    inputs.sops-nix.homeManagerModules.sops
  ];

  # sops
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/bwkam/.config/sops/age/keys.txt";

    secrets = {
      github = {};
      lat = {};
      lon = {};
    };
  };

  modules = {
    editors = {
      code.enable = true;
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
    nurl
    fd
    bat
    cava
    ranger
    (inputs.neovim.packages.x86_64-linux.neovim)
    weechat
    translate-shell
    steam-run
    typst
    typst-preview
    fzf
    google-chrome
    minetest
    cmatrix
    htop
    btop
    eza
    page
    gh
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

    # for rhythmbox
    # tracker
    # tracker-miners
    hplip
    feh

    # gui
    flameshot
    networkmanagerapplet
    mpv
    pavucontrol
    gnome.simple-scan
    (pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    gparted
    audacity
    nitrogen
    obs-studio
    simplescreenrecorder
    peek
    anki-bin

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
    PAGER = "page -q 90000 -c NONE";
    MANPAGER = "page -t man -c NONE";
  };

  systemd.user.services.gammastep.Unit.After = ["sops-nix.service"];

  services = {
    playerctld.enable = true;
    mpdris2.enable = true;
    betterlockscreen.enable = true;
    picom.enable = false;
    #

    gammastep = {
      enable = false;
      enableVerboseLogging = true;
      provider = "manual";
      longitude = ''${config.sops.secrets."lon"}'';
      latitude = ''${config.sops.secrets."lat"}'';
    };

    gnome-keyring.enable = true;
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  # when hm standalone is used, enable this
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
    userEmail = "userdev987@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
