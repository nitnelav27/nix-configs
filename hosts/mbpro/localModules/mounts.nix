{ config, lib, pkgs, ... }:
let
    nfsMount = name: device: mountPoint: {
        serviceConfig = {
            ProgramArguments = [
                "/sbin/mount_nfs"
                "-o" "resvport,soft,bg,tcp,noatime,nfsvers=4.2,noowners"
                device 
                mountPoint
            ];
            RunAtLoad = true;
            StandardErrorPath = "/var/log/mount-${name}.err.log";
            StandardOutPath = "/var/log/mount-${name}.out.log";
            StartInterval = 30;
            #After = [ "network.target" ];
        };
    };

in
    {
    launchd.daemons = {
        decreto-share = nfsMount "decreto" "10.27.81.4:/export/.decreto" "/Users/vvh/.decreto/";
        dump-share = nfsMount "dump" "10.27.81.4:/export/dump" "/Users/vvh/dump";
        docs-share = nfsMount "docs" "10.27.81.4:/export/docs" "/Users/vvh/docs";
        calibre-share = nfsMount "calibre" "10.27.81.4:export/calibre" "Users/vvh/nas/calibre";
        data-share = nfsMount "data" "10.27.81.4:export/data" "Users/vvh/nas/data";
        results-share = nfsMount "results" "10.27.81.4:export/results" "Users/vvh/nas/results";
    };
    system.activationScripts.unmountScript = ''
        /sbin/umount -f /mnt/media 2>/dev/null || true
        /sbin/umount -f /mnt/datasets 2>/dev/null || true
    '';
    }
