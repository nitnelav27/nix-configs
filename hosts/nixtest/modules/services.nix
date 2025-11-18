{ config, lib, pkgs, ... }:

{
    boot = {
        supportedFilesystems = [ "nfs" ];
        loader = {
            systemd-boot.enable = false;
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
            };
        };
    };
  
  services.openssh = {
                enable = true;
                ports = [ 1186 ];
                settings = {
                        PasswordAuthentication = true;
                };
        };
}
