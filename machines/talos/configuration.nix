{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common.nix
      ../../hardware/intel-uhd.nix
    ];

  system.copySystemConfiguration = true;
  system.stateVersion = "23.11";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams =
    [
      "video=efifb:mode=0"
      "fbcon=rotate:1"
    ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  services.xserver.xrandrHeads =
  [
    {
      output = "DSI-1";
      primary = true;
      monitorConfig = ''
        Option "Rotate" "left"
      '';
    }
  ];

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