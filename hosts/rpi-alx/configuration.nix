# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./localModules/services.nix
        ../../modules/common/storageOpt.nix
    ];

    ## swap
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 1024; ## size in megabytes
    }];

    nixpkgs.config.allowUnfree = true;

    ## Set your time zone.
    time.timeZone = "America/New_York";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
        groups = {
            vvh = {
                gid = 1000;
            };
        };
        users = {
            vvh = {
                description = "Valentin en Raspberry Pi 5. Alexandria";
                isNormalUser = true;
                uid = 1000;
                group = "vvh";
                homeMode = "764";
                shell = pkgs.zsh;
                extraGroups = [ 
                    "wheel"
                    "networkmanager"
                    "docker"
                    "podman"
                ];
				openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9CaJu6FJJ4s4NaL546RufQdrw7UB4zlChTN10avrpt valentinvergara@gmail.com"
				];
            }; 
        };
    };

    programs.zsh.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        rsync
        fastfetch
        git
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
