{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        # macOS-specific packages
        mas # Mac App Store CLI
        terminal-notifier
        # Cross-platform packages
        ripgrep
        cmake
        emacs
        gcc
        gnumake
        gnuplot
        jq
        texlab
        uv
	    wget
        zathura
        python3
    ]; 
}
