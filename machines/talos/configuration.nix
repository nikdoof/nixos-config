# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
  };

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

  hardware.opengl.extraPackages = [
    intel-media-driver
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.nikdoof = {
      isNormalUser = true;
      extraGroups = 
      [ 
        "wheel"
        "video" 
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWO2qwHaPaQs46na4Aa6gMkw5QqRHUMGQphtgAcDJOw"
      ];
    };
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    git
    lsof
    gnumake
    firefox
    python3
  ];

  programs = {
    zsh.enable = true;
    flashrom.enable = true;
    gnome-terminal.enable = true;
  };

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
    locate.enable = true;
    upower.enable = true;
    thermald.enable = true;
    fwupd.enable = true;
    smartd.enable = true;
  };
}