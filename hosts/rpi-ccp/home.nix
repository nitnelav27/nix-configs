{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "vvh";
    home.homeDirectory = "/home/vvh";

    imports = [
        ../../modules/common/terminals.nix
        ./localModules/myshell.nix
        ../../modules/common/homeBase.nix
        ../../modules/common/neovim.nix
        #../../modules/common/git.nix
        ../../modules/common/yazi.nix
    ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.05"; # Please read the comment before changing.

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        figlet-fonts = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../extra/figlet_fonts;
            target = ".config/figlet_fonts";
        };
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERMINAL = "ghostty";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
