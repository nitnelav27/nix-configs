{ config, lib, pkgs, ... }:

{
#### Disk Mounts
  ## FILM HDD
  fileSystems."/storage/film" = {
                device = "/dev/disk/by-uuid/626dfb58-995a-46cc-8340-2c611e5c9c2a";
                fsType = "ext4";
        };
  ## NAS SSD
  fileSystems."/storage/nas" = {
                device = "/dev/disk/by-uuid/ac19196b-89a8-46e4-bc59-dff00b393d45";
                fsType = "ext4";
        };
  ## TV HDD
  fileSystems."/storage/tv" = {
                device = "/dev/disk/by-uuid/8dec7836-b9d3-40d9-82b5-cc7cd0c5bda1";
                fsType = "ext4";
        };
  ## Decreto HDD
  fileSystems."/storage/.decreto" = {
                device = "/dev/disk/by-uuid/7d290586-4681-4dbc-9176-7afe20381b64";
                fsType = "ext4";
        };
  ## MUSIC SSD
  fileSystems."/storage/music" = {
                device = "/dev/disk/by-uuid/4a84e54d-1c41-4cb7-8423-ff294f90bdbc";
                fsType = "ext4";
        };
  ## TORRENTS SSD
  fileSystems."/storage/torrents" = {
                device = "/dev/disk/by-uuid/6e7c3cd0-4271-4873-84d4-1b4d210430e7";
                fsType = "ext4";
        };
  ## BIND MOUNTS: calibre 
  fileSystems."/export/calibre" = {
                device = "/storage/nas/calibre";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: data
  fileSystems."/export/data" = {
                device = "/storage/nas/data";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: dump 
  fileSystems."/export/dump" = {
                device = "/storage/nas/dump";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: migration
  fileSystems."/export/migration" = {
                device = "/storage/nas/migration";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: docs
  fileSystems."/export/docs" = {
                device = "/storage/nas/docs";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: results
  fileSystems."/export/results" = {
                device = "/storage/nas/results";
                options = [ "bind" ];
        };
  ## BIND MOUNTS: decreto
  fileSystems."/export/.decreto" = {
                device = "/storage/.decreto";
                options = [ "bind" ];
        };

}
