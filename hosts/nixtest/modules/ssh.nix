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
        };
    };

    services.ssh-agent = {
        enable = true;
    };
}
