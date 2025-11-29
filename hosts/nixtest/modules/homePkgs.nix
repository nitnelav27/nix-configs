{ config, lib, pkgs, input, ... }:
{
    home.packages = with pkgs; [
        kitty 
    ];
}
