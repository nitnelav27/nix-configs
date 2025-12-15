{ config, lib, pkgs, inputs, ... }:

{
    services.bazarr = {
        enable = true;
        dataDir = "/home/vvh/appData/bazarr";
        openFirewall = true;
        user = "vvh";
        group = "vvh";
    };
}
