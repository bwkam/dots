# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config, pkgs, inputs, ... }: {
  imports = [ ./hardware-configuration.nix ./cachix.nix ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "wolfburger"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Cairo";

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  security.polkit.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  nix.extraOptions = "experimental-features = nix-command flakes";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # X11
  services.xserver = {
    enable = true;
    layout = "us,ara";
    displayManager.lightdm.enable = true;
    displayManager.lightdm.extraConfig = "logind-check-graphical=true";
    desktopManager.xterm.enable = false;
    # BSPWM
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
  };

  services.xserver.displayManager.startx.enable = true;

  # Configure keymap in X11
  services.xserver.xkbOptions = "eurosign:e,caps:escape, grp:alt_space_toggle";
  services.blueman.enable = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  xdg.portal = {
    #wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;

  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  programs.dconf.enable = true;

  # auto-cpufreq 
  programs.auto-cpufreq.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bwkam = {
    isNormalUser = true;
    extraGroups = [ "wheel" "scanner" "lp" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    xfce.thunar
  ];

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # CPU scaling
  # programs.auto-cpufreq.enable = true;
  # programs.auto-cpufreq.settings = {
  #   charger = {
  #     governor = "performance";
  #     turbo = "auto";
  #   };
  #
  #   battery = {
  #     governor = "powersave";
  #     turbo = "auto";
  #   };
  # };

  fonts.fontDir.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
