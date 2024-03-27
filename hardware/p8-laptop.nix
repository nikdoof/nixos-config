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
}


