{ config, lib, pkgs, input, ... }:
{
    home.packages = with pkgs; [
        stdenv
        btop
        bat
        fastfetch
        ranger
        eza
        tldr
        git
        duf
        kitty
        iperf
        rsync
        docker
        wget
        curl
        acl
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
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.meslo-lg
        nerd-fonts.symbols-only
        ### End of fonts
    ];

    fonts.fontconfig.enable = true;

}
