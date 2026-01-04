{ config, lib, pkgs, inputs, ... }: 
{
    home.packages = with pkgs; [
        stdenv
        btop
        fastfetch
        eza
        tldr
        duf
        aspell
        aspellDicts.en
        aspellDicts.es
        bat
        cliphist
        dialog
        dig
        fd
        fzf
        hunspell
        hunspellDicts.en_US
        hunspellDicts.es_CL
        iperf
        killall
        nixfmt-rfc-style
        pyright
        shellcheck
        tree
        unzip
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

    fonts = {
        fontconfig.enable = true;
    };

}
