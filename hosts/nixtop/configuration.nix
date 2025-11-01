# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, inputs, pkgs, ... }:

{
    imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./modules/services.nix
        #./modules/mounts.nix
        ../../modules-common/storageOpt.nix
    ];

    # Activate swap
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 16*1024; # Size in megabytes
    }];

    # To get ride of the warning when building system 
    nix.settings.download-buffer-size = 4096*1024;

    networking = {
        hostName = "nixtop";
        networkmanager = {
            enable = true;
            dns = "none";
        };
        useDHCP = false;
        dhcpcd.enable = false;
        nameservers = [
            "10.27.81.3"
            "1.1.1.1"
            "9.9.9.9"
        ];
    };

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    # Configure keymap in X11
    # services.xserver.xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
        groups = {
            vsvh = {
                gid = 1000;
            };
        };
        users = {
            vsvh = {
                description = "Main user for desktop computer";
                isNormalUser = true;
                group = "vsvh";
                homeMode = "764";
                shell = pkgs.zsh;
                extraGroups = [
                    "wheel"
                    "networkmanager"
                ];
            };
        };
    };

    programs.zsh.enable = true;
    ## Run non-nix executables
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            uv
        ];
    };

    ## Hardware for video
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-media-driver
            libva-vdpau-driver
            libvdpau-va-gl
        ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. 
        wget
        rsync
        home-manager
        fastfetch 
        ranger
        sddm-astronaut
        #libsForQt5.qt5.qtgraphicaleffects
        uv
        #(catppuccin-sddm.override {
        #    flavor = "frappe";
        #    font = "Fira Sans";
        #    fontSize = "15";
        #})
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

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
