pull:
	nix-shell -p git --run "git pull"
update-channels:
	sudo nix-channel --update
rebuild: pull update-channels
	sudo nixos-rebuild switch -I nixos-config=machines/$(shell hostname -s)/configuration.nix
	sudo nix-collect-garbage -d
boot: pull
	sudo nixos-rebuild boot -I nixos-config=machines/$(shell hostname -s)/configuration.nix