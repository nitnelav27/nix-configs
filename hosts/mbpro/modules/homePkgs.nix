{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        # macOS-specific packages
        mas # Mac App Store CLI
        terminal-notifier

        # Cross-platform packages
        ripgrep
        fzf
        #fastfetch
        stdenv
        btop
        eza
        tldr
        duf
        aspell
        aspellDicts.en
        aspellDicts.es
        cmake
        fd
        gcc
        gnumake
        gnuplot
        hunspell
        hunspellDicts.en_US
        hunspellDicts.es_CL
        iperf
        jq
        killall
        mpv
        pyright
        ranger
        shellcheck
        texlab
        tree
        unzip
        uv
	wget
        zathura

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
