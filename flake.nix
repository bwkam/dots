{
  description = "bwkam's nixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";

    nurpkgs.url = "github:nix-community/NUR";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    dwm.url = "github:bwkam/dwm";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # ghostty = { url = "git+ssh://git@github.com/mitchellh/ghostty"; };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      alphaWolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./home/configuration.nix
          inputs.auto-cpufreq.nixosModules.default
          inputs.agenix.nixosModules.default

          { nix.nixPath = [ "nixpkgs=flake:nixpkgs" ]; }

          {
            environment.systemPackages =
              [ inputs.agenix.packages."x86_64-linux".default ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bwkam = import ./home/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };

          }
        ];
      };
    };

    devShells.x86_64-linux = {
      default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell { buildInputs = [ git lua-language-server lua ]; };
    };
  };

}
