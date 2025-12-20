{ config, lib, pkgs, ... }:

let
    portList = [
        2049 ## NFS
    ];

in
{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = portList; 
        allowedUDPPorts = portList; 
    };
}
