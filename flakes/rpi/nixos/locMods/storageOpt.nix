{ config, lib, pkgs, ... }:

{
    ### Optimise the store every time the configuration file rebuilds
    nix.settings.auto-optimise-store = true;

    ### Garbage collection
    nix.gc = {
        automatic = true;
        dates = "Fri *-*-* 12:00:00";
        options = "--delete-older-than 30d";
    };

}
