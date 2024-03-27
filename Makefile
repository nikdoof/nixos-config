pull:
	nix-shell -p git --run "git pull"
rebuild:
	sudo nixos-rebuild switch -I nixos-config=machines/$(shell hostname -s)/configuration.nix