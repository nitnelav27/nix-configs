{ config, lib, pkgs, input, ... }:
{
    home.packages = with pkgs; [
        stdenv
        btop
        bat
        fastfetch
        eza
        tldr
        git
        duf
        kitty
        iperf
        cuetools
        shntool
        flac
        xsel
        ### Fonts start here
        barlow
        fira
        hasklig
        source-code-pro
        material-design-icons
        material-icons
        noto-fonts
        roboto
        ubuntu-sans
        ubuntu-sans-mono
        weather-icons
        font-awesome
        noto-fonts-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.meslo-lg
        nerd-fonts.symbols-only
        ### End of fonts
    ];

    fonts.fontconfig.enable = true;

}
