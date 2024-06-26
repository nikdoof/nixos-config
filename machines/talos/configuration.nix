{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../hardware/p8-laptop.nix
      ../../common.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  system.stateVersion = "23.11";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;


  networking.hostName = "talos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    firefox
    obsidian
    vscode-fhs
    gnome.gnome-power-manager
    gnomeExtensions.screen-rotate
  ];

  programs = {
    flashrom.enable = true;
    gnome-terminal.enable = true;
  };

  services.tailscale.enable = true;
  services.fstrim.enable = true;

  services.logind.lidSwitchDocked = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
}