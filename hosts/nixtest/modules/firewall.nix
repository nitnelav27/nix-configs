{ config, lib, pkgs, ... }:

let
    portList = [
        28981 ## Paperless-ngx
    ];

in
{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = portList; 
        allowedUDPPorts = portList; 
    };
}
