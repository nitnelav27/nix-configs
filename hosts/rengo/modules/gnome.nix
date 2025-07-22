{ config, lib, pkgs, inputs, ... }: 
{
    services.displayManager.gdm = {
        enable = true;
        banner = "Welcome back, Smithers!";
        autoSuspend = false;
    };
    services.desktopManager.gnome.enable =true;
}
