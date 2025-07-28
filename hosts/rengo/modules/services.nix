{ config, lib, pkgs, inputs, ... }: 
{
    services = {
        samba = {
            enable = true;
            openFirewall = true;
            settings = {
                global = {
                    "workgroup" = "VSVH";
                    "server string" = "smbnix";
                    "netbios name" = "smbnix";
                    "security" = "user";
                    #"use sendfile" = "yes";
                    #"max protocol" = "smb2";
                    # note: localhost is the ipv6 localhost ::1
                    "hosts allow" = "10.27.115. 127.0.0.1 localhost";
                    "hosts deny" = "0.0.0.0/0";
                    "guest account" = "nobody";
                    "map to guest" = "bad user";
                };
                "decree" = {
                    "path" = "/storage/nas/.decreto";
                    "browseable" = "yes";
                    "read only" = "no";
                    "guest ok" = "no";
                    "create mask" = "0644";
                    "directory mask" = "0755";
                    "force user" = "rengo";
                    "force group" = "rengo";
                };
            };
        };
        samba-wsdd = {
            enable = true;
            openFirewall = true;
        };
        avahi = {
            publish.enable = true;
            publish.userServices = true;
            # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
            nssmdns4 = true;
            # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
            enable = true;
            openFirewall = true;
        };
        openssh = {
            enable = true;
            ports = [ 9273 ];
            settings = {
                PasswordAuthentication = true;
                KbdInteractiveAuthentication = true;
                PermitRootLogin = "no";
            };
        };
    };
}
