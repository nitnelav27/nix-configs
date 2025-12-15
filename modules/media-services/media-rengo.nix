{ config, lib, pkgs, inputs, ... }:

{
    imports = [
        ./bazarr.nix
        ./radarr.nix
        ./lidarr.nix
        ./sonarr.nix
        ./deluge.nix
        ./prowlarr.nix
        ./navidrome.nix
    ];
}
