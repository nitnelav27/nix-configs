{ config, lib, pkgs, ... }:

{
  imports = [
                ./hardware-configuration.nix 
                ./modules/mounts.nix
                ./modules/services.nix
                ./modules/firewall.nix 
                ../../modules-common/nvidia.nix
        ];
   
  nixpkgs.config = {
                allowUnfree = true;
                nvidia.acceptLicense = true;
        }; 
  networking = {
                hostName = "dockmedia";
                networkmanager = {
                        enable = true;
                        dns = "none";
                };
                useDHCP = false;
                dhcpcd.enable = false;
                nameservers = [
                        "10.27.3.14"
                        "75.75.75.75"
                        "75.75.76.76"
                ];
        };

  # Set your time zone.
  time.timeZone = "America/New_York";

  users = {
                groups = {
                        docko = {
                                gid = 1000;
                        };
                };
                users = {
                        docko = {
                                description = "Docker containers VM";
                                isNormalUser = true;
                                uid = 1000;
                                group = "docko";
                                homeMode = "755";
                                shell = pkgs.zsh;
                                extraGroups = [ "wheel" "docker" ];
                        };
                        tm = {
                                description = "User for Time Machine backups";
                                isNormalUser = true;
                                createHome = false;
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
  system.stateVersion = "24.11"; # Did you read the comment?

}

