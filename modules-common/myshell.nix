{ config, lib, pkgs, inputs, ... }:

{
    ## zsh as shell
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        dotDir = ".config/zsh";
        history.size = 1000;
        history.save = 10000;
        history.path = "~/.local/share/zsh/history";
        history.ignorePatterns = [ "rm *" "pkill *" "l *" "cp *" ];
        history.ignoreDups = true;
        shellAliases = {
            l = "eza --group --icons";
        };
        initContent = ''
            ####### This is zsh specific syntax
            path+=($HOME/.local/bin)
            path+=($HOME/.config/scripts)
            path+=($HOME/.config/emacs/bin)
            if [[ "$(hostname -s)" == "mbpro" ]]; then 
            path+=(/Library/TeX/texbin)
            fi
            # Enable colors
            autoload -U colors && colors

            autoload -Uz compinit
            compinit
            if [[ "$(hostname -s)" == "nixtop" ]]; then
            eval "$(uv generate-shell-completion zsh)"
            fi
            source $ZDOTDIR/plugins/colored-man-pages.plugin.zsh
        '';
        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.fetchFromGitHub {
                    owner = "zsh-users";
	                repo = "zsh-autosuggestions";
	                rev = "0.7.1";
	                sha256 = "sha256-vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
	            };
            }
            {
                name = "vi-mode";
	            src = pkgs.zsh-vi-mode;
	            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
        ];
    };

    programs.starship = {
        enable = true;
        settings = {
            add_newline = false;
            format = "$username$hostname$directory$nix_shell$git_branch$git_status$python$cmd_duration\n$jobs$character";
            character = {
                success_symbol = "[λ](bold green) ";
                error_symbol = "[✗](bold red) ";
            };
            username = {
                style_user = "bold #00909e";
                show_always = true;
            };
            hostname = {
                ssh_only = true;
                trim_at = ".local";
                style = "bold dimmed white";
            };
            git_branch = {
                always_show_remote = true;
            };
            cmd_duration = {
                min_time = 10000;
            };
        };
    };
}
