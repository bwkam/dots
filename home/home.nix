{ pkgs, inputs, ... }:

let
  nixpkgs-unstable-latest = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };

in {
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
      code.enable = true;
    };

    desktop = {
      bspwm.enable = true;
      hyprland.enable = true;
      gtk.enable = true;
      rofi.enable = true;
      polybar.enable = true;
    };

    browsers = { firefox.enable = true; };

    dev = { lazygit.enable = true; };

    terminal = {
      kitty.enable = true;
      alacritty.enable = true;
    };

    misc = {
      neofetch.enable = true;
      pywal.enable = false;
      wallust.enable = true;
      picom.enable = true;
      cava.enable = true;
      zathura.enable = true;
      xdg.enable = true;
      # starship.enable = true;
    };

    # shell = { fish.enable = false; };
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

  # programs.fish.enable = true;

  home.packages = with pkgs; [
    # format
    nixfmt
    tailwindcss-language-server
    nodePackages.prettier
    alejandra
    rustfmt

    # gnu
    gcc
    gdb

    # cli
    nnn
    inetutils
    ffmpeg
    pandoc
    go
    sad
    lazygit
    nurl
    jless
    pfetch
    btop
    gotop
    ranger
    cloc
    chafa
    links2
    gh
    zellij
    tcpdump
    nixpkgs-review
    (weechat.override {
      configure = { ... }: {
        scripts = with pkgs.weechatScripts; [
          weechat-matrix
          weechat-notify-send
        ];
      };
    })
    nil
    nmap
    pipewire
    cmatrix
    pipes
    lua54Packages.luacheck
    gnumake
    nix-prefetch-github
    htop
    eza
    gnumeric
    ripgrep
    xorg.xkill
    xclip
    xsel
    xdotool
    git
    playerctl
    steam-run
    yt-dlp
    glxinfo
    pciutils
    cachix
    cmus
    hugo
    #wine-staging
    bottles
    # wineWowPackages.staging
    # (wine.override { wineBuild = "wine64"; })
    wineWowPackages.stagingFull
    winetricks
    mumble
    appimage-run
    unzip
    gping
    openssl
    usbutils

    # languages
    (inputs.nixpkgs-unstable.legacyPackages."x86_64-linux".haxe)
    python39
    rustc
    cargo
    rust-analyzer
    nodejs_20
    python311Packages.pip
    zip
    clang-tools
    nil
    newsflash
    tor-browser
    networkmanagerapplet
    xonotic
    minetest
    renderdoc
    gtk3
    gtk4
    gparted
    google-chrome
    rhythmbox
    tracker
    mpv
    mpvScripts.mpris
    libresprite
    tracker-miners
    hplip
    dmenu
    pavucontrol
    flameshot
    gimp
    kdenlive
    nixpkgs-unstable-latest.avogadro2
    nixpkgs-unstable-latest.marvin
    feh
    obs-studio
    simplescreenrecorder
    peek
    obsidian
    zoom-us
    lmms
    audacity
    gnome.simple-scan
    gnome.cheese
    rofimoji
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

    (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" "Meslo" ]; })
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

  home.sessionVariables = { EDITOR = "nvim"; };

  services = {
    playerctld.enable = true;
    betterlockscreen.enable = true;
    # dunst.enable = true;

    gnome-keyring.enable = true;
  };

  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     firefox.speechSynthesisSupport = true;
  #   };
  #
  #   overlays = [
  #     inputs.neovim-nightly-overlay.overlay
  #     inputs.nurpkgs.overlay
  #     inputs.neorg-overlay.overlays.default
  #     (import ../overlays { inherit pkgs lib inputs; })
  #   ];
  # };

  nix.extraOptions = "experimental-features = nix-command flakes";
  #nix.package = pkgs.nix;

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
