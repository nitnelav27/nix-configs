{ config, pkgs, lib, inputs, ... }:

{
    home.username = "vvh";
    home.homeDirectory = "/Users/vvh";  # macOS uses /Users instead of /home

    imports = [
        ../../modules-common/terminals.nix
        ../../modules-common/myshell.nix
        ../../hosts/mbpro/modules/homePkgs.nix  # Host-specific packages
        ../../modules-common/neovim.nix
        ../../modules-common/git.nix
    ];


    home.stateVersion = "24.11";

    home.sessionVariables = {
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        DOOMDIR = "$HOME/.config/doom";
        IPYTHONDIR = "$HOME/.config/ipython";
        JUPYTER_CONFIG_DIR = "$HOME/.config/jupyter";
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERMINAL = "kitty";  # Confirmed macOS compatible
        VIDEO = "mpv";
        OPENER = "open";     # macOS native opener
        PAGER = "less";
        BROWSER = "firefox";
    };

    programs.home-manager.enable = true;
}
