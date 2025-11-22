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
            };
            "dockmedia" = {
                hostname = "10.27.81.4";
                port = 1186;
                user = "docko";
                identityFile = "~/.ssh/id_ed25519";
            };
            "proxmox" = {
                hostname = "10.27.81.2";
                port = 1186;
                user = "root";
                identityFile = "~/.ssh/id_ed25519";
            };
            "macbook" = {
                hostname = "10.27.81.81";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
            "macbook-wired" = {
                hostname = "10.27.81.82";
                port = 1186;
                user = "vvh";
                identityFile = "~/.ssh/id_ed25519";
            };
            "rpi-alx" = {
                hostname = "10.27.81.3";
                port = 1186;
                user = "uno";
                identityFile = "~/.ssh/id_ed25519";
            };
            "hopper-gmu" = {
                hostname = "amd004";
                user = "vvergara";
                port = 22;
                proxyJump = "hopper-gmu-headnode";
                identityFile = "~/.ssh/id_ed25519";
            };
            "hopper-gmu-headnode" = {
                hostname = "hopper.orc.gmu.edu";
                user = "vvergara";
                port = 22;
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
            "nixtest" = {
                hostname = "10.27.81.84";
                port = 1186;
                user = "dos";
                identityFile = "~/.ssh/id_ed25519";
            };
        };
    };

    services.ssh-agent = {
        enable = true;
    };
}
