{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  services.openssh = {
                enable = true;
                ports = [ 1186 ];
                settings = {
                        PasswordAuthentication = true;
                };
        };
}
