{ config, lib, pkgs, ... }:

{
    # Add Intel UHD vaapi support
    imports = [
        ./intel-uhd.nix
    ];

    # Fix on boot framebuffer res and rotation
    boot.kernelParams =
    [
        "video=efifb:mode=0"
        "video=DSI-1:panel_orientation=right_side_up"
        "fbcon=rotate:1"
    ];
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Provide rotation to X/Wayland
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


