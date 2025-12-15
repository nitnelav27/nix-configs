{ config, lib, pkgs, inputs, ... }:

{
    services.radarr = {
        enable = true;
        openFirewall = true;
        user = "vvh";
        group = "vvh";
        dataDir = "/home/vvh/appData/radarr";
    };
}
