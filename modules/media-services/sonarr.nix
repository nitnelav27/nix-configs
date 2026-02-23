{ config, lib, pkgs, inputs, ... }:

{
    services.sonarr = {
        enable = true;
        openFirewall = true;
        dataDir = "/home/vvh/appData/sonarr";
        user = "vvh";
        group = "vvh";
    };

    systemd.services.sonarr.serviceConfig = {
        # Use lib.mkForce to resolve the conflict with the default module
        ProtectHome = lib.mkForce "read-only"; 
        ReadWritePaths = [ "/home/vvh/appData/sonarr" ];
    };
}
