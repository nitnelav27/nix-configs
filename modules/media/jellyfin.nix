{ config, lib, pkgs, inputs, ... }:

{
    services.jellyfin = {
        enable = true;
        openFirewall = true;
        user = "vvh";
        group = "vvh";
        dataDir = "/home/vvh/appData/jellyfin/data";
        configDir = "/home/vvh/appData/jellyfin/config";
        cacheDir = "/home/vvh/appData/jellyfin/cache";
        logDir = "/home/vvh/appData/jellyfin/log";
    };
}
