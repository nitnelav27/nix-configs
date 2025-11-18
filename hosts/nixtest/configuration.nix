# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  
imports = [
                /etc/nixos/hardware-configuration.nix 
                ./modules/network.nix
                ./modules/services.nix
                ./modules/mounts.nix
                ../../modules-common/storageOpt.nix
                ../../media/jellyfin.nix
        ]; 

    # Set your time zone.
  time.timeZone = "America/New_York";

  users = {
                groups = {
                        dos = {
                                gid = 1000;
                        };
                };
                users = {
                        dos = {
                                description = "Test user";
                                isNormalUser = true;
                                uid = 1000;
                                group = "dos";
                                homeMode = "764";
                                shell = pkgs.zsh;
                                extraGroups = [ "wheel" ];
                        };
                };
        };

  programs.zsh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    rsync
    home-manager
    ranger
    fastfetch
    neo-cowsay
    acl
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
  ];

   
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

