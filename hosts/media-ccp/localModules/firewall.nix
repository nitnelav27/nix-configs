{ config, lib, pkgs, ... }:

let
    portList = [
        ### NFS starts here
        111  
        2049
        4000
        4001
        4002
        20048
        ### NFS ends here
    ];

in
{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = portList; 
        allowedUDPPorts = portList; 
    };
}
