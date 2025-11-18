{ config, lib, pkgs, ... }:
let
        HOME = "/home/dos";
        nasLocation = "10.27.81.4";
        commonOpts = [
          "x-systemd.automount"
          "x-systemd.requires=network-online.target"
        ];
in
{
        fileSystems = {
                "/storage/docs" = {
                        device = "${nasLocation}:/docs";
                        fsType = "nfs";
                        options = commonOpts;
                }; 
        };
}
