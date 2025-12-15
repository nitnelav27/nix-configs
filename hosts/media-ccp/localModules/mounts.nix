{ config, lib, pkgs, ... }:

{
    #### Disk Mounts
    ## MEDIA HDD
    fileSystems."/storage/media" = {
        device = "/dev/disk/by-uuid/6fadb1cd-4f4a-4ae7-818b-a46a0c403a92";
        fsType = "ext4";
    };
    ## NAS SSD
    fileSystems."/storage/nas" = {
        device = "/dev/disk/by-uuid/3acfea27-9081-4a46-bfc1-22fcc6806eb5";
        fsType = "ext4";
    };
    ## Decreto HDD
    fileSystems."/storage/.decreto" = {
        device = "/dev/disk/by-uuid/7d290586-4681-4dbc-9176-7afe20381b64";
        fsType = "ext4";
    };
    ## TORRENTS SSD
    fileSystems."/storage/torrents" = {
        device = "/dev/disk/by-uuid/8a116a4a-9084-441e-bf3b-d1be77c8f132";
        fsType = "ext4";
    };
    ## BIND MOUNTS: calibre 
    #fileSystems."/export/calibre" = {
    #            device = "/storage/nas/calibre";
    #            options = [ "bind" ];
    #    };
  ## BIND MOUNTS: data
    #fileSystems."/export/data" = {
    #            device = "/storage/nas/data";
    #            options = [ "bind" ];
    #    };
  ## BIND MOUNTS: dump 
    #fileSystems."/export/dump" = {
    #            device = "/storage/nas/dump";
    #            options = [ "bind" ];
    #    };
  ## BIND MOUNTS: migration
    #fileSystems."/export/migration" = {
    #            device = "/storage/nas/migration";
    #            options = [ "bind" ];
    #    };
  ## BIND MOUNTS: docs
#fileSystems."/export/docs" = {
    #           device = "/storage/nas/docs";
    #           options = [ "bind" ];
    #   };
  ## BIND MOUNTS: results
    #fileSystems."/export/results" = {
    #           device = "/storage/nas/results";
    #           options = [ "bind" ];
    #   };
  ## BIND MOUNTS: decreto
    #fileSystems."/export/.decreto" = {
    #           device = "/storage/.decreto";
    #           options = [ "bind" ];
    #   };

}
