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
            "292D3E"
            "444267"
            "32374D"
            "676E95"
            "8796B0"
            "959DCB"
            "959DCB"
            "FFFFFF"
            "F07178"
            "F78C6C"
            "FFCB6B"
            "C3E88D"
            "89DDFF"
            "82AAFF"
            "C792EA"
            "FF5370"
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