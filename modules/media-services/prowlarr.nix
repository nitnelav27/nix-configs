{ config, lib, pkgs, inputs, ... }:

{
    services.prowlarr = {
        enable = true;
        openFirewall = true;
        dataDir = "/home/vvh/appData/prowlarr";
        settings = {
            update.automatically = true;
            update.mechanism = "builtIn";
        };
    };
}
