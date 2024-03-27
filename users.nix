{ config, lib, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    users.nikdoof = {
      isNormalUser = true;
      extraGroups = 
      [ 
        "wheel"
        "networkmanager"
        "video" 
        "audio"
      ];
      linger = true;
      initialPassword = "pass1234";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWO2qwHaPaQs46na4Aa6gMkw5QqRHUMGQphtgAcDJOw"
      ];
      packages = with pkgs; [
        tmux
      ];
    };
  };
}