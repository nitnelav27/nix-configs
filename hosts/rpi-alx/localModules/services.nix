{ config, lib, inputs, pkgs, ... }:

{
    # Use Raspberry pi Kernel boot.
    boot = {
        kernelParams = [ "dtparam=nvme" ];
        loader = {
            grub.enable = false;
            raspberryPi.bootloader = "kernel";
        };
    };

    networking = {
        hostName = "rpi-alx";
        #networkManager = {
        #    enable = true;
        #    dns = "none";
        #};
        useDHCP = false;
        dhcpcd.enable = false;
        interfaces.end0 = {
            ipv4.addresses = [
                {
                    address = "10.27.81.3";
                    prefixLength = 24;
                }
            ];
        };
        defaultGateway = "10.27.81.1";
        nameservers = [
            "1.1.1.1"
            "9.9.9.9"
        ];
    };

    programs.ssh.startAgent = true;

    services.openssh = {
        enable = true;
        ports = [ 1186 ];
        settings = {
            PasswordAuthentication = true;
        };
    };
 
    virtualisation = {
        containers.enable = true;
        docker = {
            enable = true;
        };
        podman = {
            enable = true;
            #dockerCompat = true;
        };
    };
}
