{ config, lib, pkgs, inputs, ... }:

{
    services.jellyfin = {
        enable = true;
        openFirewall = true;
        user = "dos";
        group = "dos";
    };
}
