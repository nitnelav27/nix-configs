{ config, lib, pkgs, inputs, ... }:

{
    services.radarr = {
        enable = true;
        openFirewall = true;
        user = "vvh";
        group = "vvh";
        dataDir = "/home/vvh/appData/radarr";
    };

    systemd.services.radarr.serviceConfig = {
        # Use lib.mkForce to resolve the conflict with the default module
        ProtectHome = lib.mkForce "read-only"; 
        ReadWritePaths = [ "/home/vvh/appData/radarr" ];
    };}
