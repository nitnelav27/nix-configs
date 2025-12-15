{ config, lib, pkgs, inputs, ... }:

{
    services.sonarr = {
        enable = true;
        openFirewall = true;
        dataDir = "/home/vvh/appData/sonarr";
        user = "vvh";
        group = "vvh";
    };
}
