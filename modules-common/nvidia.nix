{ config, lib, pkgs, ... }:

{
        hardware = {
                nvidia = {
                        modesetting.enable = true;
                        open = true;
                        nvidiaSettings = false;
                        powerManagement.enable = false;
                        powerManagement.finegrained = false;
                };
                nvidia-container-toolkit = {
                        enable = true;
                };
        };

        services.xserver.videoDrivers = [ "nvidia" ];
}
