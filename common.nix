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
        font = "spleen-12x24";
        useXkbConfig = true; # use xkb.options in tty.
        colors = [
            "363c51"
            "ff5370"
            "c4e88d"
            "ffcb6b"
            "82aaff"
            "c692e9"
            "8addff"
            "b5bbd6"
            "676e95"
            "ff5370"
            "c3e88d"
            "ffcb6b"
            "82a9fe"
            "c792e9"
            "8addff"
            "88ddff"
            "ffffff"
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