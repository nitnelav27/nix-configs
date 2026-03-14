{ config, lib, pkgs, inputs, ... }:

{
    services.qbittorrent = {
        enable = true;
        package = pkgs.qbittorrent-nox;
        user = "vvh";
        group = "vvh";
        openFirewall = true;
        profileDir = "/home/vvh/appData/qBittorrent";
        webuiPort = 8080;
    };
}
