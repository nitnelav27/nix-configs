{ config, lib, pkgs, inputs, ... }:
{
  services = {
    displayManager.gdm.enble = true;
    desktopManager.gnome.enable = true;
    ## Disable all of gnome's bloat
    gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
  ];
}
