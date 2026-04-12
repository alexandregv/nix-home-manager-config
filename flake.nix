{
  description = "Home Manager configuration of Reach";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hister.url = "github:asciimoo/hister";
    bluebuild.url = "https://flakehub.com/f/blue-build/cli/v0.9.35.tar.gz";
  };

  outputs =
    { nixpkgs, unstable, home-manager, hister, bluebuild, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        # config.allowUnfree = true;
        overlays = [
          (final: prev: {
            hister = hister.packages.${prev.stdenv.hostPlatform.system}.default;
            bluebuild = bluebuild.packages.${prev.stdenv.hostPlatform.system}.default;
          })
        ];
      };

      unstablePkgs = import unstable {
        inherit system;
        # config.allowUnfree = true;
      };
    in
    {
      homeConfigurations."reach" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit unstablePkgs;
        };

        modules = [
	  ./home.nix
	];
      };
    };
}
