{ config, lib, pkgs, inputs, ... }:

{
    services.deluge = {
        enable = true;
        user = "vvh";
        group = "vvh";
        web = {
            enable = true;
            openFirewall = true;
        };
        openFirewall = true;
        dataDir = "/home/vvh/appData/deluge";
        config = {
            download_location = "/storage/torrents";
            allow_remote = true;
        };
    };
}
