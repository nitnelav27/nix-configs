# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, inputs, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ./localModules/services.nix
        ./localModules/mounts.nix
        ./localModules/nvidia.nix
        ../../modules/common/storageOpt.nix
    ];

    # Activate swap
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 16*1024; # Size in megabytes
    }];

    
    networking = {
        hostName = "nixtop-ccp";
        networkmanager = {
            enable = true;
            dns = "none";
        };
        useDHCP = false;
        dhcpcd.enable = false;
        nameservers = [
            "10.27.115.1"
            #"10.27.81.3"
            #"10.27.81.19"
        ];
    };

    # Set your time zone.
    time.timeZone = "America/Santiago";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "es_CL.UTF-8";
      LC_IDENTIFICATION = "es_CL.UTF-8";
      LC_MEASUREMENT = "es_CL.UTF-8";
      LC_MONETARY = "es_CL.UTF-8";
      LC_NAME = "es_CL.UTF-8";
      LC_NUMERIC = "es_CL.UTF-8";
      LC_PAPER = "es_CL.UTF-8";
      LC_TELEPHONE = "es_CL.UTF-8";
      LC_TIME = "es_CL.UTF-8";
    };
    i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
  };
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
                    "video"
                    "render"
                    "networkmanager"
                ];
                openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFJCb1Zizshyqfe8h8SprkjkgDqKe+PMPDT6WvEjF+wT MacOS on mbpro m5 pro"
                ];
            };
        };
    };

    programs.zsh.enable = true;
    ## Run non-nix executables
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            stdenv.cc.cc
            zlib
            fuse3
            icu
            nss
            openssl
            curl
            expat
            uv
        ];
    };

    ## Hardware for video
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    #    extraPackages = with pkgs; [
    #        intel-media-driver
    #        libva-vdpau-driver
    #        libvdpau-va-gl
    #    ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
        systemPackages = with pkgs; [
            vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default. 
            wget
            rsync
            home-manager
            fastfetch 
            sddm-astronaut
            #libsForQt5.qt5.qtgraphicaleffects
            uv
            rpi-imager
            zstd
            #(catppuccin-sddm.override {
            #    flavor = "frappe";
            #    font = "Fira Sans";
            #    fontSize = "15";
            #})
        ];
        sessionVariables = {
            LIBVA_DRIVER_NAME = "nvidia";
            GBM_BACKEND = "nvidia-drm";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            # Required for 50-series/Wayland cursor visibility
            WLR_NO_HARDWARE_CURSORS = "1";
            # Helps SDDM and Hyprland find the correct DRM seat
            XDG_SESSION_TYPE = "wayland";
            MUTTER_DEBUG_FORCE_KMS_MODE = "simple"; # Helps GDM draw on Nvidia
        };
    };

    
  systemd = {
    services = {
      display-manager = {
        after = [
          "graphical-desktop.target"
          "nvidia-drm-output.target" 
          "network-online.target" 
        ];
        wants = [
          "nvidia-drm-output.target"
        ];
        requires = [
          "nvidia-drm-output.target"
        ];
      };
    };
    user = {
      extraConfig = ''
        DefaultEnvironment="PATH=/usr/bin:/bin"
        DefaultEnvironment="LIBVA_DRIVER_NAME=nvidia"
        DefaultEnvironment="GBM_BACKEND=nvidia-drm"
        DefaultEnvironment="__GLX_VENDOR_LIBRARY_NAME=nvidia"
      '';
    };
  };

  services.greetd = {
        enable = true;
        settings = {
            default_session = {
                # This drops you into a text-based login prompt.
                # Once you log in, it automatically runs your UWSM Hyprland command.
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd 'uwsm start hyprland-uwsm.desktop'";
                user = "greeter";
            };
        };
    };

    # Optional but recommended: This prevents boot messages from mixing 
    # with the login prompt on the screen.
    systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal"; 
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
    }; 
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # To get ride of the warning when building system 
    nix.settings = {
        download-buffer-size = 4096*1024;
        sandbox = true;
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

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
