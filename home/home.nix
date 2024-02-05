{ config, osConfig, pkgs, lib, inputs, ... }:
let
  # my-fonts = pkgs.callPackage ./fonts/default.nix { inherit pkgs; };
  # spicetify-nix = inputs.spicetify-nix;
  # nixvim = inputs.nixvim;
  # helix = inputs.helix;

  sys = osConfig.modules.system;
in {
  imports = [
    ./modules/desktop/bspwm.nix
    ./modules/desktop/hyprland.nix
    ./modules/editors/neovim
    ./fish.nix
    ./kitty.nix
    ./codium.nix
    ./gtk.nix
    ./polybar
    ./xdg.nix
    ./picom.nix
    ./rofi
    ./neofetch
    ./ncmpcpp.nix
    ./mpd.nix
    ./firefox
    ./zathura
    ./modules/editors/doom-emacs

    # ./helix
    # ./spicetify.nix
  ];

  modules = {
    editors = {
      # emacs.enable = true;
      nvim.enable = true;
      doom-emacs.enable = true;
    };
    desktop = {
      bspwm.enable = true;
      hyprland.enable = true;
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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # term emulators
    kitty

    # shells
    fish

    # format
    nixfmt
    alejandra
    rustfmt

    # gnu
    gcc
    gdb

    # osu 
    osu-lazer-bin

    # cli
    lazygit
    pfetch
    btop
    gotop
    ranger
    neofetch
    chafa
    links2
    gh
    zellij
    traceroute
    tcpdump
    nixpkgs-review
    nil
    nmap
    # helix
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
    codeblocks
    pciutils
    cmus
    hugo
    #wine-staging
    bottles
    # wineWowPackages.staging
    # (wine.override { wineBuild = "wine64"; })
    wineWowPackages.stagingFull
    winetricks
    appimage-run
    unzip
    gradle
    cargo-watch
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
    #    jdk11
    python311Packages.pip
    zip
    clang-tools
    nil
    # flutter
    # gui
    minetest
    renderdoc
    gtk3
    gtk4
    foliate
    gparted
    google-chrome
    gnome.gnome-music
    amberol
    tracker
    mpv
    libresprite
    tracker-miners
    hplip
    dmenu
    pavucontrol
    flameshot
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    gimp
    kdenlive
    feh
    obs-studio
    simplescreenrecorder
    neochat
    obsidian
    grapejuice
    zoom-us
    lmms
    audacity
    jetbrains.rust-rover
    gnome.simple-scan
    gnome.cheese
    rofimoji
    teams-for-linux
    #teams

    #calibre

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

  home.sessionVariables = {
    EDITOR = "nvim";
    NIX_PATH = "nixpkgs=flake:nixpkgs\${NIX_PATH:+:$NIX_PATH}";
    WINEPREFIX = "$HOME/spitfire"; # for lmms VST loading
    WINELOADER =
      "$HOME/.local/share/bottles/runners/soda-8.0.2/bin/wine"; # for lmms VST loading
    WINEDLLPATH =
      "$HOME/.local/share/bottles/runners/soda-8.0.2/lib/wine/x86_64-unix"; # for lmms VST loading
  };

  services = {
    playerctld.enable = true;
    betterlockscreen.enable = true;

    gnome-keyring.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
      firefox.speechSynthesisSupport = true;
    };

    overlays = [ inputs.nurpkgs.overlay ];
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.package = pkgs.nix;

  # dconf
  dconf.enable = true;

  # idk why
  programs = {
    direnv = {
      enable = true;
      #enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    fish.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "bwkam";
    userEmail = "beshoykamel391@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
