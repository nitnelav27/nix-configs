{ config, lib, inputs, pkgs, ... }:

{
    security.rtkit.enable = true;
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    services.avahi.enable = true;
    services.udisks2.enable = true;
        
    # Use GRUB.
    boot = {
        ## uncomment below to build a sd-image for raspberry pi
        #binfmt.emulatedSystems = [ "aarch64-linux" ];
        supportedFilesystems = [ "nfs" ];
        loader = {
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;
            grub = {
                enable = true;
                efiSupport = true;
                device = "nodev";
            };
        };
    };

    services.openssh = {
        enable = true;
        ports = [ 1186 ];
        settings = {
            PasswordAuthentication = false;
        };
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

}
