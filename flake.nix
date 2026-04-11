{
  description = "Home Manager configuration of Reach";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-config = {
      url = "github:thrix/nix-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    { nixpkgs, home-manager, nix-config, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."reach" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
           nix-config.homeManagerModules.hostConfig
	  ./home.nix
	];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
