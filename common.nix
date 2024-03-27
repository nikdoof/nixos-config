{ config, lib, pkgs, ... }:

{
    imports = [
        ./users.nix
    ];

    system.copySystemConfiguration = true;

    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; # use xkb.options in tty.
    };

    programs = {
        zsh.enable = true;
    };

    environment.systemPackages = with pkgs; [
        git
        gnupg
        lsof
        gnumake
        python3
    ];

    services = {
        openssh = {
            enable = true;
            settings = {
                PermitRootLogin = "yes";
            };
        };
    };
}