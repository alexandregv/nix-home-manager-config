default: check switch

check:
	nix flake check
	home-manager build --flake . -n

switch:
	home-manager switch --flake .

.PHONY: default check switch
