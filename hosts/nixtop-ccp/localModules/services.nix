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

    # 1. Disable the flapping service
  services.timesyncd.enable = false;

  # 2. Enable Chrony for more robust syncing
  services.chrony.enable = true;
  
  # 3. Use the South America pool for better latency
  networking.timeServers = lib.mkForce [
    "0.south-america.pool.ntp.org"
    "1.south-america.pool.ntp.org"
    "time.google.com"
  ];

  ## This is for using English and Spanish keyboard layouts
  console = {
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb = {
    layout = "us,es";
    variant = ","; # Leave blank for default variants, or use "intl" for US if you want dead keys there too
    options = "grp:caps_toggle"; # Toggle between US and ES using caps key
  };

  ## Ollama
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [
      "llama3.1:8b"
      "deepseek-r1:8b"
    ];
  };
  services.open-webui.enable = true;
}
