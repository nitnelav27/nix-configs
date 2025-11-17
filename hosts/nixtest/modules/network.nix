{ config, lib, pkgs, input, ... }:
{
    networking = {
        hostName = "nixtest";
        networkmanager = {
            enable = true;
        };
    };
}
