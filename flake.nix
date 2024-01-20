{
  description = "bwkam's nixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nurpkgs.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      alpha-wolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          { nix.nixPath = [ "nixpkgs=flake:nixpkgs" ]; }
        ];
      };
    };

    homeConfigurations."bwkam" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [ ./home/home.nix ];
      extraSpecialArgs = { inherit inputs; };
    };

    devShells.x86_64-linux = {
      default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell { buildInputs = [ git lua-language-server lua npm2nix ]; };
    };
  };
}
