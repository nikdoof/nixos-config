{ config, lib, pkgs, ... }:

{
    imports = [
        users.nix
    ];

    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; # use xkb.options in tty.
    };
}