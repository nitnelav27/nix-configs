{ config, lib, pkgs, input, ... }:
{
    home.packages = with pkgs; [
        acl
        dnslookup
    ];

}
