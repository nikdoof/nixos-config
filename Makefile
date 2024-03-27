pull:
	nix-shell -p git --run "git pull"
rebuild: pull
	sudo nixos-rebuild switch -I nixos-config=machines/$(shell hostname -s)/configuration.nix