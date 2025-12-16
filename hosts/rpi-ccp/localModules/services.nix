{ config, lib, inputs, pkgs, ... }:

{
    # Use Raspberry pi Kernel boot.
    boot = {
        kernelParams = [ "dtparam=nvme" ];
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            grub.enable = false;
            raspberryPi.bootloader = "kernel";
        };
    };

    networking = {
        hostName = "rpi-ccp";
        useDHCP = false;
        dhcpcd.enable = false;
        interfaces.end0 = {
            ipv4.addresses = [
                {
                    address = "10.27.115.3";
                    prefixLength = 24;
                }
            ];
        };
        defaultGateway = "10.27.115.1";
        nameservers = [
            "10.27.115.1"
        ];
    };

    programs.ssh.startAgent = true;

    services = {
        openssh = {
            enable = true;
            ports = [ 1186 ];
            settings = {
                PasswordAuthentication = true;
            };
        };
        timesyncd = {
            enable = true;
            servers = [ 
                "pool.ntp.org" 
                "time.google.com" 
            ];
        };
    };
 
    virtualisation = {
        containers.enable = true;
        docker = {
            enable = true;
        };
        #podman = {
        #    enable = true;
            #dockerCompat = true;
        #};
    };
}
