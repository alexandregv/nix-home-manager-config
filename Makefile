default: check switch

check:
	nix flake check
	home-manager build --flake . -n

build:
	home-manager build --flake .

switch:
	home-manager switch --flake . -b backup

.PHONY: default check build switch
