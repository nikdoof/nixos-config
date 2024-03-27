
rebuild:
	nixos-rebuild switch -I nixos-config=machines/$(shell hostname -s)/configuration.nix