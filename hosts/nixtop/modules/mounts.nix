{ config, lib, pkgs, ... }:
let
        HOME = "/home/vsvh";
        nasLocation = "10.27.27.89";
        commonOpts = [
          "x-systemd.automount"
          "x-systemd.requires=network-online.target"
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
                "${HOME}/nas/migration" = {
                        device = "${nasLocation}:/migration";
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
