{ config, lib, pkgs, hostname, ... }:

{
    ## Required for flake use 
    nix.settings.experimental-features = "nix-command flakes";

    # System settings
    system.stateVersion = 6;
    networking.hostName = hostname;
  
    # User configuration
    users.users.vvh = {
        home = "/Users/vvh";
        shell = pkgs.zsh;
    };
}
