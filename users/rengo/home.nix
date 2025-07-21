{ config, pkgs, lib, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "rengo";
    home.homeDirectory = "/home/rengo";

    imports = [
        ../../modules-common/terminals.nix 
        ../../modules-common/myshell.nix 
        #../../modules-common/hyprland.nix
        #../../modules-common/hyprlock.nix
        #../../hosts/rengo/modules/homePkgs.nix
        #../../hosts/rengo/modules/homeServices.nix
        ../../modules-common/neovim.nix
        ../../modules-common/git.nix
        ../../modules-common/mpv.nix
        #../../modules-common/rofi.nix
    ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.11"; # Please read the comment before changing.

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/vsvh/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
        NIXOS_OZONE_WL = "1";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        IPYTHONDIR = "$HOME/.config/ipython";
        JUPYTER_CONFIG_DIR = "$HOME/.config/jupyter";
        EDITOR = "nvim";
        READER = "zathura";
        VISUAL = "nvim";
        TERMINAL = "kitty";
        VIDEO = "mpv";
        OPENER = "xdg-open";
        PAGER = "less";
        BROWSER = "firefox";
        NASDATA = "$HOME/nas/data";
        NASRES = "$HOME/nas/results";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
