{ config, lib, pkgs, ... }:

{
  imports = [
                /etc/nixos/hardware-configuration.nix 
                ./localModules/network.nix
        #./localModules/mounts.nix
                ./localModules/services.nix
        #./localModules/firewall.nix
        #../../modules/media/nvidia.nix
                ../../modules/common/storageOpt.nix
        ]; 

    # Set your time zone.
  time.timeZone = "America/Santiago";

  users = {
        groups = {
            vvh = {
                gid = 1000;
            };
        };
        users = {
            vvh = {
                description = "NixOS media host. Concepcion";
                isNormalUser = true;
                uid = 1000;
                group = "vvh";
                homeMode = "764";
                shell = pkgs.zsh;
                extraGroups = [ "wheel" "docker" ];
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9CaJu6FJJ4s4NaL546RufQdrw7UB4zlChTN10avrpt valentinvergara@gmail.com"
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMN8XsCLVMNTOIntJfoZ6/KS6luhHM9FfOSqN+in175h Valentin Vergara Hidd on MacOS"
                ];
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

