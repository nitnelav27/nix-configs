{ config, pkgs, lib, inputs, ... }:

{
    home.username = "vvh";
    home.homeDirectory = "/Users/vvh";  # macOS uses /Users instead of /home

    imports = [
        ../../modules-common/terminals.nix
        ../../hosts/mbpro/modules/myshell.nix
        ../../hosts/mbpro/modules/homePkgs.nix  # Host-specific packages
        ../../modules-common/neovim.nix
        #../../modules-common/nixvim.nix
        ../../hosts/mbpro/modules/git.nix
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

    home.file = {
        doom = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../modules-common/extra/doom;
            target = ".config/doom";
        };
        matplotlib = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../modules-common/extra/matplotlib;
            target = ".config/matplotlib";
        };
        jupyter = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../modules-common/extra/jupyter;
            target = ".config/jupyter";
        };
        scripts = {
            enable = true;
            executable = true;
            recursive = true;
            source = ../../modules-common/extra/scripts;
            target = ".config/scripts";
        };
        figlet-fonts = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../modules-common/extra/figlet_fonts;
            target = ".config/figlet_fonts";
        };
    };

    programs.home-manager.enable = true;
}
