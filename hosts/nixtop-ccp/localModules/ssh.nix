{ config, lib, pkgs, inputs, ... }:

{
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
            "*" = {
                forwardAgent = false;
                addKeysToAgent = "no";
                compression = false;
                serverAliveInterval = 0;
                serverAliveCountMax = 3;
                hashKnownHosts = false;
                userKnownHostsFile = "~/.ssh/known_hosts";
                controlMaster = "no";
                controlPath = "~/.ssh/master-%r@%n:%p";
                controlPersist = "no";
                setEnv = {
                    TERM = "xterm-256color";
                };
            };
            "proxmox" = {
                hostname = "10.27.81.2";
                port = 1186;
                user = "root";
                identityFile = "~/.ssh/id_ed25519";
            };
            "macbook" = {
                hostname = "10.27.115.81";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
            "macbook-wired" = {
                hostname = "10.27.115.82";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
            "rpi-alx" = {
                hostname = "10.27.81.3";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            }; 
            "github.com" = {
                port = 22;
                addKeysToAgent = "yes";
                identityFile = "~/.ssh/id_ed25519";
            };
            "git.gandalf.studio" = {
                port  = 22;
                addKeysToAgent = "yes";
                identityFile = "~/.ssh/id_ed25519";
            };
            "media-ccp" = {
                hostname = "10.27.115.4";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
            "rpi-ccp" = {
                hostname = "10.27.115.3";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
        };
    };

    services.ssh-agent = {
        enable = true;
    };
}
