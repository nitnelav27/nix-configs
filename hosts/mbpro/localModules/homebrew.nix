{ config, lib, pkgs, ... }:
{
    homebrew = {
        enable = true;
        casks = [
            "firefox"
            "kitty"
            "slack"
            "calibre"
            "zoom"
            "adobe-acrobat-reader"
            "mactex"
	        "whatsapp"
	        "via"
            "ollama"
#"raspberry-pi-imager"
#"logi-options+"
            "ghostty"
#"spotify"
            "rar"
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
