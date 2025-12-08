{ config, pkgs, inputs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "vvh";
    home.homeDirectory = "/home/vvh";

    imports = [
        ../../modules/common/myshell.nix
        ../../modules/common/neovim.nix
        ../../modules/common/git.nix
        ../../modules/common/homeBase.nix
        ./localModules/homePkgs.nix
        ../../modules/common/yazi.nix
    ];
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
  
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        scripts = {
            enable = true;
            executable = true;
            recursive = true;
            source = ../../extra/scripts;
            target = ".config/scripts";
        };
        figlet-fonts = {
            enable = true;
            executable = false;
            recursive = true;
            source = ../../extra/figlet_fonts;
            target = ".config/figlet_fonts";
        };
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
    #  /etc/profiles/per-user/naso/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        EDITOR = "nvim";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
