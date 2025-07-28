{ config, lib, pkgs, ... }:

{
#### Disk Mounts
  ## FILM HDD
  fileSystems."/storage/film" = {
                device = "/dev/disk/by-uuid/be8317f6-b62b-4c7e-8241-d2c422171409";
                fsType = "ext4";
        };
  ## NAS SSD
  fileSystems."/storage/nas" = {
                device = "/dev/disk/by-uuid/151fdfb7-116f-42ca-9680-092f7c8c1140";
                fsType = "ext4";
        };
  ## TV HDD
  fileSystems."/storage/tv" = {
                device = "/dev/disk/by-uuid/fe7e2bc1-ed3b-4338-9416-b174306f47b6";
                fsType = "ext4";
        };
  ## TORRENTS SSD
  fileSystems."/storage/torrents" = {
                device = "/dev/disk/by-uuid/5d9e23b0-c3de-40fb-9881-abfb15841f69";
                fsType = "ext4";
        };
  
}
