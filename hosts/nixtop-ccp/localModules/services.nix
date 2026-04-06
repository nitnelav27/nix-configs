{ config, lib, inputs, pkgs, ... }:

{
    security.rtkit.enable = true;
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    services.avahi.enable = true;
    services.udisks2.enable = true;
        
    # Use GRUB.
    boot = {
        initrd = {
            kernelModules = [
                "nvidia"
                "nvidia_modeset"
                "nvidia_uvm"
                "nvidia_drm"
            ];
        };
        ## uncomment below to build a sd-image for raspberry pi
        #binfmt.emulatedSystems = [ "aarch64-linux" ];
        supportedFilesystems = [ "nfs" ];
	    kernelPackages = pkgs.linuxPackages_latest;
        kernelParams = [
            "nvidia-drm.modeset=1"
            "nvidia-drm.fbdev=1"
            # This tells the kernel to ignore the simple boot splash and 
            # wait for the real driver
            "video=efifb:off"
        ];
        loader = {
            systemd-boot.enable = false;
            efi = {
                canTouchEfiVariables = false;
   		        efiSysMountPoint = "/boot";
	        };
            grub = {
                enable = true;
                efiSupport = true;
		        efiInstallAsRemovable = true;
                device = "nodev";
            };
        };
    };

    services.openssh = {
        enable = true;
        openFirewall = true;
        ports = [ 1186 ];
        settings = {
            PasswordAuthentication = true;
        };
        extraConfig = ''
            AllowTcpForwarding yes
        '';
    };
 
    virtualisation.docker = {
        enable  = true;
    };

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        raopOpenFirewall = true;
        extraConfig.pipewire = {
            "10-airplay" = {
                "context.modules" = [{
                    name = "libpipewire-module-raop-discover";
                }];
            };
        };
        wireplumber.extraConfig = {
            "10-bluez" = {
                "monitor.bluez.properties" = {
                    "bluez5.enable-sbc-xq" = true;
                    "bluez5.enable-msbc" = true;
                    "bluez5.enable-hw-volume" = true;
                    "bluez5.roles" = [
                        "hsp_hs"
                        "hsp_ag"
                        "hfp_hf"
                        "hfp_ag"
                    ];
                };
            };
        };
    };

    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        # Force SDDM to use the wayland greeting even if it defaults to X11
        settings = {
          General = {
            DisplayServer = "wayland";
            GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
          };
        };
        theme = "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;
        extraPackages = [
            pkgs.sddm-astronaut
            pkgs.kdePackages.qtmultimedia
            pkgs.kdePackages.qtwayland
        ];
    };
    
    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        withUWSM = true;
        xwayland.enable = true;
    };

    services.hypridle = {
        enable = true;
    };

    services.solaar = {
        enable = true;
        batteryIcons = "solaar";
    };

    services.timesyncd = {
        enable  = true;
        servers = [
            "0.pool.ntp.org"
            "1.pool.ntp.org"
        ];
    };

    systemd.services.display-manager.after = [ "nvidia-drm-output.target" ];

    systemd.user.extraConfig = ''
        DefaultEnvironment="PATH=/usr/bin:/bin"
        DefaultEnvironment="LIBVA_DRIVER_NAME=nvidia"
        DefaultEnvironment="GBM_BACKEND=nvidia-drm"
        DefaultEnvironment="__GLX_VENDOR_LIBRARY_NAME=nvidia"
    '';

}
