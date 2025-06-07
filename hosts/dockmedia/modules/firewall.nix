{ config, lib, pkgs, ... }:

{
        networking.firewall = {
                enable = true;
                allowedTCPPorts = [
                        111
                        2049
                        4000
                        4001
                        4002
                        4533 ## navidrome
                        5201 ## iperf
                        6767 ## bazarr
                        7878 ## radarr
                        8080 ## qbittorrent
                        8096 ## jellyfin
                        8191 ## flaresolverr
                        8686 ## lidarr
                        8989 ## sonarr
                        9696 ## prowlarr
                        20048
                        36403 ## AirVPN
                ];
                allowedUDPPorts = [
                        111
                        2049
                        4000
                        4001
                        4002
                        4533 ## navidrome
                        5201 ## iperf
                        6767 ## bazarr
                        7878 ## radarr
                        8080 ## qbittorrent
                        8096 ## jellyfin
                        8191 ## flaresolverr
                        8686 ## lidarr
                        8989 ## sonarr
                        9696 ## prowlarr
                        20048
                        36403 ## AirVPN
                ];
        };
}
