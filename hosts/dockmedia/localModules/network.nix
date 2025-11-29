{ config, lib, pkgs, input, ... }:
{
    networking = {
        hostName = "dockmedia";
        networkmanager = {
            enable = true;
            dns = "none";
        };
        useDHCP = false;
        dhcpcd.enable = false;
        interfaces.ens18 = {
            ipv4.addresses = [
                {
                    address = "10.27.81.4";
                    prefixLength = 24;
                }
            ];
        };
        defaultGateway = "10.27.81.1";
        nameservers = [
            #"10.27.81.3"
            "1.1.1.1"
            "9.9.9.9"
        ];
    };
}
