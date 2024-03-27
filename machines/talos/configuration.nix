{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../hardware/p8-laptop.nix
      ../../common.nix
    ];

  system.copySystemConfiguration = true;
  system.stateVersion = "23.11";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "talos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";
  services.xserver.libinput.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable sensors
  hardware.sensor.iio.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    firefox
  ];

  programs = {
    flashrom.enable = true;
    gnome-terminal.enable = true;
  };

  # Enable the OpenSSH daemon.
  services = {
    locate.enable = true;
    upower.enable = true;
    thermald.enable = true;
    fwupd.enable = true;
    smartd.enable = true;
  };
}