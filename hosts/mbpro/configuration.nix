{ config, lib, pkgs, hostname, ... }:

{
    ## Imports
    imports = [
        ./modules/mounts.nix
        ./modules/system.nix
        ./modules/storageOpt.nix
    ];
    ## Required for flake use 
    nix.settings.experimental-features = "nix-command flakes";

    # System settings
    system.stateVersion = 6;
    networking.hostName = hostname;
    
    ## System Packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        mkalias
    ];

    ## System Activation script for Aliases
    system.activationScripts.applications.text = let 
        env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
        };
    in 
        pkgs.lib.mkForce ''
            # Set up applications
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
                app_name=$(basename "$src")
                echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
        '';
    
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
