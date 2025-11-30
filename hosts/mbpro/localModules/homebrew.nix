{ config, lib, pkgs, ... }:
{
    homebrew = {
        enable = true;
        casks = [
            "firefox"
            "kitty"
            "slack"
            "microsoft-office"
            "calibre"
            "microsoft-teams"
            "zoom"
            "adobe-acrobat-reader"
            "mactex"
	        "whatsapp"
	        "via"
            "raspberry-pi-imager"
            "logi-options+"
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
}
