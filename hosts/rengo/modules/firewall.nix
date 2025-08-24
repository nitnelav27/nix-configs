{ config, lib, pkgs, ... }:

let
    portList = [
        1186 ## remote ssh
        5201 ## iperf
        6767 ## bazarr
        7878 ## radarr
        8080 ## qbittorrent
        8096 ## jellyfin
        8191 ## flaresolverr
        8989 ## sonarr
        9696 ## prowlarr
    ];

in
{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = portList; 
        allowedUDPPorts = portList; 
    };
}
