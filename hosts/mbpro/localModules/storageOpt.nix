{ config, lib, pkgs, ... }:

{
    ### Optimise the store every time the configuration file rebuilds
    nix.optimise = {
        automatic = true;
        interval = {
            Hour = 12;
            Minute = 12;
            Weekday = 5;
        };
    };

    ### Garbage collection
    nix.gc = {
        automatic = true;
        interval = {
            Hour = 12;
            Minute = 55;
            Weekday = 4;
        };
        options = "--delete-older-than 30d";
    };

}
