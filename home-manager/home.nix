{ config
, pkgs
, lib
, inputs
, ...
}:
let
  haxe-overlay = import ./haxe.nix {
    inherit config lib pkgs;
  };
  my-fonts = pkgs.callPackage ./fonts/default.nix { inherit pkgs; };
  nur = inputs.nurpkgs;
  spicetify-nix = inputs.spicetify-nix;
  nixvim = inputs.nixvim;
in
{
  imports = [
    (import ./bspwm.nix { inherit config lib pkgs; })
    (import ./fish.nix { inherit config lib pkgs; })
    (import ./kitty.nix { inherit config lib pkgs; })
    (import ./codium.nix { inherit config lib pkgs; })
    (import ./gtk.nix { inherit config lib pkgs; })
    (import ./polybar { inherit config lib pkgs; })
    (import ./xdg.nix { inherit config lib pkgs; })
    (import ./picom.nix { inherit config lib pkgs; })
    (import ./rofi { inherit config lib pkgs; })
    (import ./neovim { inherit config lib pkgs nixvim; })
    (import ./neofetch { inherit config lib pkgs; })
    (import ./ncmpcpp.nix { inherit config lib pkgs; })
    (import ./firefox { inherit config lib pkgs nur; })
    (import ./zathura { inherit config lib pkgs; })
    (import ./spicetify.nix { inherit config lib pkgs spicetify-nix; })
  ];

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

    # cli
    neofetch
    helix
    htop
    exa
    ripgrep
    xorg.xkill
    xclip
    xsel
    xdotool
    cava
    cypress
    git
    playerctl
    yt-dlp
    spotdl
    cmus
    hugo
    wine-staging
    appimage-run
    unzip
    gradle
    cargo-watch
    gping
    wrangler_1
    postman
    openssl
    usbutils
    nodePackages_latest.pnpm
    nodePackages.http-server


    # languages
    haxe
    python39
    go
    rustc
    cargo
    rust-analyzer
    nodejs_20
    neko
    jdk11
    python311Packages.pip
    zip
    clang-tools
    nil
    # flutter

    # gui
    gtk3
    gtk4
    hplip
    dmenu
    pavucontrol
    flameshot
    inputs.gpt4all.packages.${pkgs.system}.gpt4all-chat-avx
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    gimp
    kdenlive
    feh
    obs-studio
    google-chrome
    neochat
    obsidian
    blender
    grapejuice
    zoom-us
    lmms
    audacity
    gnome.simple-scan
    gnome.cheese
    rofimoji
    teams

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
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    GTK_THEME = "Catppuccin-Mocha-Standard-Pink-dark";
    NIX_PATH = "nixpkgs=flake:nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
  };

  services = {
    playerctld.enable = true;
    betterlockscreen.enable = true;

    gnome-keyring.enable = true;

    mpd = {
      dataDir = "/home/bwkam/.config/mpd";
      musicDirectory = "/home/bwkam/Music";
      playlistDirectory = "/home/bwkam/Music";
      enable = true;
      network = {
        port = 6601;
      };
      extraConfig = ''
        #db_file "~/.mpd/mpd.db"
        #log_file "~/.mpd/mpd.log"
        #pid_file "~/.mpd/mpd.pid"
        #state_file "~/.mpd/mpdstate"
        audio_output {
        	type "pulse"
        	name "pulse audio"
        }
        audio_output {
            type                    "fifo"
            name                    "my_fifo"
            path                    "/tmp/mpd.fifo"
            format                  "44100:16:2"
        }
      '';
    };


  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
    };

    overlays = [ haxe-overlay inputs.nurpkgs.overlay ];
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  # nix.package = pkgs.nix;

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
    userEmail = "userdev987@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
