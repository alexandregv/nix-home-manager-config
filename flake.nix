{
  description = "Home Manager configuration of Reach";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager-src = {
      url = "github:nix-community/home-manager/release-25.11";
      flake = false;
    };

    hister.url = "github:asciimoo/hister";
    bluebuild.url = "https://flakehub.com/f/blue-build/cli/v0.9.35.tar.gz";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    { nixpkgs, unstable, home-manager-src, hister, bluebuild, nix-flatpak, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        # config.allowUnfree = true;
        overlays = [
          (final: prev: {
            bluebuild = bluebuild.packages.${prev.stdenvNoCC.hostPlatform.system}.default;
          })
        ];
      };

      unstablePkgs = import unstable {
        inherit system;
        # config.allowUnfree = true;
      };

      # I don't like the "warning: 'install' is a deprecated alias for 'add'" warning
      patchedHomeManagerSrc = pkgs.runCommand "home-manager-patched" {} ''
        cp -R ${home-manager-src} $out
        chmod -R u+w $out
        substituteInPlace $out/modules/home-environment.nix \
          --replace-fail "profile install" "profile add"
      '';

      home-manager = import patchedHomeManagerSrc {
        inherit pkgs;
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
          hister.homeModules.default
          nix-flatpak.homeManagerModules.nix-flatpak
	];
      };
    };
}
