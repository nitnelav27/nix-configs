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
    networking.hostName = "mbpro";
    
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
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9CaJu6FJJ4s4NaL546RufQdrw7UB4zlChTN10avrpt valentinvergara@gmail.com"
        ];
    };

    ## This is to deal with spotlight
    system.activationScripts.postActivation.text = ''
        # Set up the applications folder for Spotlight
        echo "setting up /Applications/Nix Apps..." >&2
  
        # Remove the existing directory to ensure a clean state
        rm -rf "/Applications/Nix Apps"
        mkdir -p "/Applications/Nix Apps"
  
        # Note: Replace 'vvh' with your actual username if it differs from the log
        # We look in the per-user profile where Home Manager and Darwin link apps
        apps_source="/etc/profiles/per-user/vvh/Applications/"

        if [ -d "$apps_source" ]; then
        find "$apps_source" -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
        app_name=$(basename "$src")
        ln -s "$src" "/Applications/Nix Apps/$app_name"
        done
        fi
    '';
}
