{ config, lib, pkgs, hostname, ... }:

{
    ## Imports
    imports = [
        ./modules/mounts.nix
        ./modules/system.nix
        ./modules/homebrew.nix
        ./modules/storageOpt.nix
    ];

    ## Required for flake use 
    nix.settings.experimental-features = "nix-command flakes";

    # System settings
    system.stateVersion = 6;
    networking.hostName = hostname;
    
    ## System Packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = [
        pkgs.mkalias
    ]; 

        
    ## Services 
    services = {
        openssh = {
            enable = true;
            extraConfig = ''
                Port 1186
            '';
        };
    };
  
    # User configuration
    users.users.vvh = {
        home = "/Users/vvh";
        shell = pkgs.zsh;
    };
}
