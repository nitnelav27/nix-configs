{ config, lib, pkgs, inputs, ... }:

{
    services.lidarr = {
        enable = true;
        user = "vvh";
        group = "vvh";
        openFirewall = true;
        dataDir = "/home/vvh/appData/lidarr";
    };
}
