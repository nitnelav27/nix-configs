{ config, lib, pkgs, hostname, ... }:

{
    ## Required for flake use 
    nix.settings.experimental-features = "nix-command flakes";

    # System settings
    system.stateVersion = 6;
    networking.hostName = hostname;
    system.primaryUser = "vvh";
    system.defaults = {
        LaunchServices.LSQuarantine = false;
        NSGlobalDomain = {
            AppleICUForce24HourTime = true;
            AppleInterfaceStyle = "Dark";
            AppleMeasurementUnits = "Centimeters";
            AppleMetricUnits = 1;
            AppleShowAllExtensions = true;
            AppleTemperatureUnit = "Celsius";
            "com.apple.mouse.tapBehavior" = 1;
        };
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
        controlcenter = {
            BatteryShowPercentage = true;
            Bluetooth = true;
            Sound = true;
        };
        dock = {
            autohide = true;
            mineffect = "suck";
            orientation = "right";
            static-only = true;
        };
        finder = {
            AppleShowAllExtensions = true;
            CreateDesktop = false;
            FXRemoveOldTrashItems = true;
            ShowPathbar = true;
        };
        iCal = {
            "TimeZone support enabled" = true;
            "first day of week" = "Monday";
        };
        loginwindow = {
            GuestEnabled = false;
            SHOWFULLNAME = false;
        };
        menuExtraClock = {
            Show24Hour = true;
            ShowDate = 1;
        };
        trackpad.Clicking = true;
    };

    ## System Packages
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
        mkalias
    ];

    ## System Activation script for Aliases
    system.activationScripts.applications.text = let 
        env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
        };
    in 
        pkgs.lib.mkForce ''
            # Set up applications
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
                app_name=$(basename "$src")
                echo "copying $src" >&2
                ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
        '';
    
    ## Homebrew
    homebrew = {
        enable = true;
        casks = [
            "firefox"
            "kitty"
            "slack"
            "microsoft-office"
        ];
        brews = [
            "imagemagick"
            "mas"
        ];
        onActivation = {
            cleanup = "zap";
            upgrade = true;
        };
    }; 

    ## Services 
    services = {
        openssh = {
            enable = true;
            extraConfig = ''
                Port 1186
            '';
        };
    };
  
    # User configuration
    users.users.vvh = {
        home = "/Users/vvh";
        shell = pkgs.zsh;
    };
}
