{
  description = "bwkam's nixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	
     gpt4all.url = github:polygon/gpt4all-nix;
     nurpkgs.url = github:nix-community/NUR;
     spicetify-nix.url = github:the-argus/spicetify-nix;

    helix = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
    url = "github:nix-community/nixvim";
    # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    # url = "github:nix-community/nixvim/nixos-23.05";

    inputs.nixpkgs.follows = "nixpkgs";
  };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      alpha-wolf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix

	  {nix.nixPath = ["nixpkgs=flake:nixpkgs"];}


	  # HM
	  home-manager.nixosModules.home-manager {
	  home-manager.useUserPackages = true;
	   home-manager.users.bwkam = import ./home-manager/home.nix;
	   home-manager.extraSpecialArgs = {inherit inputs;};
	  }
        ];
      };
    };
  };
}
