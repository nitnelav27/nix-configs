{ config, lib, pkgs, ... }:
let
    HOME = "/Users/vvh";
    nasLocation = "10.27.81.4";
    commonOpts = [
        "noatime"
        "nfsvers=4.2"
        "resvport"
        "soft"
        "bg"
        "tcp"
        #"x-systemd.automount"
        #"x-systemd.requires=network-online.target"
    ];
in
    {
    fileSystems = {
        "${HOME}/.decreto" = {
            device = "${nasLocation}:/.decreto";
            fsType = "nfs";
            options = commonOpts;
        };

        "${HOME}/nas/calibre" = {
            device = "${nasLocation}:/calibre";
            fsType = "nfs";
            options = commonOpts;
        };

        "${HOME}/nas/data" = {
            device = "${nasLocation}:/data";
            fsType = "nfs";
            options = commonOpts;
        };

        "${HOME}/dump" = {
            device = "${nasLocation}:/dump";
            fsType = "nfs";
            options = commonOpts;
        };

        "${HOME}/docs" = {
            device = "${nasLocation}:/docs";
            fsType = "nfs";
            options = commonOpts;
        };

        "${HOME}/nas/results" = {
            device = "${nasLocation}:/results";
            fsType = "nfs";
            options = commonOpts;
        };
    };
}
