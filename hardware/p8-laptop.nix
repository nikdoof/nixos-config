{ config, lib, pkgs, ... }:

{
    # Add Intel UHD vaapi support
    imports = [
        ./intel-uhd.nix
    ];

    # Extra kernel modules
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "thunderbolt" ];

    # Fix on boot framebuffer res and rotation
    boot.kernelParams =
    [
        "video=efifb:mode=0"
        "video=DSI-1:panel_orientation=right_side_up"
        "fbcon=rotate:1"
    ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Fix the font rendering
	fonts.fontconfig = {
		subpixel.rgba = "vbgr";  # Pixel order for rotated screen

		# The OLED display has √(1920² + 1200²) px / 8in ≃ 283 dpi
		# Per the documentation, antialiasing, hinting, etc. have no visible effect at such high pixel densities anyhow.
		# Set manually, as the hiDPI module had incorrect settings prior to NixOS 22.11; see nixpkgs#194594.
		hinting.enable = false;
        antialias = false;
	};

    # The keyboard is US layout
    services.xserver.xkb.layout = "us";

    # Enable sensors
    hardware.sensor.iio.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable touch input
    services.xserver.libinput.enable = true;

    # Enable some standard services
    services = {
        upower.enable = true;
        thermald.enable = true;
        fwupd.enable = true;
        smartd.enable = true;
    };
}


