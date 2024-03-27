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
	};

    # The keyboard is US layout
    services.xserver.xkb.layout = "us";

    # Enable sensors
    hardware.sensor.iio.enable = true;
    services.udev.extraHwdb = ''
        sensor:modalias:acpi:BOSC0200*:dmi:*
          ACCEL_MOUNT_MATRIX=-1, 0, 0; 0, 1, 0; 1, 0, 0
    '';

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


