{ config, lib, pkgs, hostname, ... }:

{
    ## Imports
    imports = [
        ./localModules/mounts.nix
        ./localModules/system.nix
        ./localModules/homebrew.nix
        ./localModules/storageOpt.nix
    ];

    ## Required for flake use 
    nix.settings.experimental-features = "nix-command flakes";

    # System settings
    system.stateVersion = 6;
    networking.hostName = hostname;
    
    ## System Packages 
    nixpkgs.config = { 
        allowUnfree = true;
        allowUnsupportedSystem = true;
    };
    environment.systemPackages = with pkgs; [
        mkalias
        vim
	    home-manager
    ]; 

    ## Environment variables to help with darwin compilation
    environment.variables = {
        MACOSX_DEPLOYEMENT_TARGET = "26.0.1";
    };

        
    ## Services 
    services = {
        openssh = {
            enable = true;
            #extraConfig = ''
            #    Port 1186
            #'';
        };
    };
  
    # User configuration
    users.users.vvh = {
        home = "/Users/vvh";
        shell = pkgs.zsh;
    };
}
