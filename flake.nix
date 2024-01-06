{
  description = "bwkam's nixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurpkgs.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      alpha-wolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix

          {
            nix.nixPath = ["nixpkgs=flake:nixpkgs"];
          }

          # HM
          # home-manager.nixosModules.home-manager {
          # home-manager.useUserPackages = true;
          #  home-manager.users.bwkam = import ./home-manager/home.nix;
          #  home-manager.extraSpecialArgs = {inherit inputs;};
          # }
        ];
      };
    };

    homeConfigurations."bwkam" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [./home/home.nix];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
