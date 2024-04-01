{ config, lib, pkgs, ... }:

{
    imports = [
        ./users.nix
    ];

    nix.settings.max-jobs = lib.mkDefault 1;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    users.motdFile = builtins.path {
        path = ./files/motd; 
        name = "motd"; 
    };

    system.copySystemConfiguration = true;

    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
        packages = [ pkgs.spleen ];
        font = "spleen-16x32";
        useXkbConfig = true; # use xkb.options in tty.
        colors = [
            "363537"
            "ff6188"
            "a9dc76"
            "ffd866"
            "fc9867"
            "ab9df2"
            "78dce8"
            "fdf9f3"
            "908e8f"
            "ff6188"
            "a9dc76"
            "ffd866"
            "fc9867"
            "ab9df2"
            "78dce8"
            "fdf9f3"
        ];
    };

    programs = {
        git.enable = true;
        zsh.enable = true;
    };

    environment.systemPackages = with pkgs; [
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