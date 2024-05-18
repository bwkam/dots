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

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    nurpkgs.url = "github:nix-community/NUR";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";

    # my flakes
    suckless.url = "github:bwkam/suckless/dev";
    neovim.url = "github:bwkam/nvim/master";

    ghostty = {
      url = "git+ssh://git@github.com/mitchellh/ghostty";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      alphaWolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/configuration.nix

          inputs.auto-cpufreq.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          # inputs.nix-index-database.hmModules.nix-index

          # { programs.nix-index-database.comma.enable = true; }
          {nix.nixPath = ["nixpkgs=flake:nixpkgs"];}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bwkam = import ./home/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };

    nixConfig = {
      extra-substituters = ["https://ghostty.cachix.org" "https://cache.garnix.io"];
      extra-trusted-public-keys = ["ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=" "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
    };

    devShells.x84_64-linux = {
      default = with nixpkgs.legacyPackages.x86_64-linux;
        mkShell {
          buildInputs = [
            git
            lua-language-server
            lua
            vim
          ];
        };
    };
  };
}
