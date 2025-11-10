{ config, lib, pkgs, inputs, ... }:

{
    ## Hyprland config
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            monitor = [
                "DP-3, 3440x1440@99.98, 0x0, 1"
                "DP-5, 2560x1440@59.95, 3440x0, 1"
            ];
            ## Local variables
            "$terminal" = "kitty";
            "$fileManager" = "thunar";
            "$menu" = "rofi -show drun";
            "$SwitchLayout" = "hyprctl -q switchxkblayout current next";
            #################
            ### AUTOSTART ###
            #################
            # Autostart necessary processes (like notifications daemons, status bars, etc.)
            # Or execute your favorite apps at launch like this:
            exec-once = [
                "$HOME/.config/hypr/scripts/wallpaper-hyprland"
                "$HOME/.config/hypr/scripts/xdg_bar"
                "wl-paste --type text --watch cliphist store"
                "wl-paste --type image --watch cliphist store"
                "thunderbird"
                "firefox"
                "slack"
            ];
            #############################
            ### ENVIRONMENT VARIABLES ###
            #############################
            env = [
                "XCURSOR_SIZE,24"
                "HYPRCURSOR_SIZE,24"
            ];
            #####################
            ### LOOK AND FEEL ###
            #####################
            general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
                # https://wiki.hyprland.org/Configuring/Variables/#variable-types info about colors
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
                # Set to true enable resizing windows by clicking and dragging on borders and gaps
                resize_on_border = false;
                # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
                allow_tearing = false;
                layout = "master";
            };
            # https://wiki.hyprland.org/Configuring/Variables/#decoration
            decoration = {
                rounding = 10;
                rounding_power = 2;
                # Change transparency of focused and unfocused windows
                active_opacity = "1.0";
                inactive_opacity = "1.0";
                shadow =  {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };
                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur =  {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = "0.1696";
                };
            };
            # https://wiki.hyprland.org/Configuring/Variables/#animations
            animations =  {
                enabled = "yes, please :)";
                # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
                bezier = [
                    "easeOutQuint,0.23,1,0.32,1"
                    "easeInOutCubic,0.65,0.05,0.36,1"
                    "linear,0,0,1,1"
                    "almostLinear,0.5,0.5,0.75,1.0"
                    "quick,0.15,0,0.1,1"
                ];
                animation = [
                    "global, 1, 10, default"
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            dwindle = {
                pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true; # You probably want this
            };
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            master = {
                new_status = "slave";
                mfact = 0.67;
            };
            # https://wiki.hyprland.org/Configuring/Variables/#misc
            misc = {
                force_default_wallpaper = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
                disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
            };
            #############
            ### INPUT ###
            #############
            # https://wiki.hyprland.org/Configuring/Variables/#input
            input = {
                kb_layout = "us,es";
                follow_mouse = 1;
                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
                touchpad = {
                    natural_scroll = false;
                };
            };
            # https://wiki.hyprland.org/Configuring/Variables/#gestures
            #gestures = {
            #    workspace_swipe = false;
            #};
            ###################
            ### KEYBINDINGS ###
            ###################
            # See https://wiki.hyprland.org/Configuring/Keywords/
            "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind = [
                "$mainMod, Return, exec, $terminal"
                "$mainMod, Q, killactive,"
                "$mainMod SHIFT, Q, exit,"
                "$mainMod SHIFT, E, exec, $fileManager"
                "$mainMod SHIFT, F, togglefloating,"
                "$mainMod, Space, exec, $menu" # rofi in wayland 
                "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
                "$mainMod, P, pseudo," # dwindle
                "$mainMod, J, togglesplit," # dwindle
                "$mainMod SHIFT, K, exec, $SwitchLayout"
                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"
                # Switch workspaces with mainMod + [0-9]
                "$mainMod, 1, workspace, 1"
                "$mainMod, 2, workspace, 2"
                "$mainMod, 3, workspace, 3"
                "$mainMod, 4, workspace, 4"
                "$mainMod, 5, workspace, 5"
                "$mainMod, 6, workspace, 6"
                "$mainMod, 7, workspace, 7"
                "$mainMod, 8, workspace, 8"
                "$mainMod, 9, workspace, 9"
                "$mainMod, 0, workspace, 10"
                # Move active window to a workspace with mainMod + SHIFT + [0-9]
                "$mainMod SHIFT, 1, movetoworkspace, 1"
                "$mainMod SHIFT, 2, movetoworkspace, 2"
                "$mainMod SHIFT, 3, movetoworkspace, 3"
                "$mainMod SHIFT, 4, movetoworkspace, 4"
                "$mainMod SHIFT, 5, movetoworkspace, 5"
                "$mainMod SHIFT, 6, movetoworkspace, 6"
                "$mainMod SHIFT, 7, movetoworkspace, 7"
                "$mainMod SHIFT, 8, movetoworkspace, 8"
                "$mainMod SHIFT, 9, movetoworkspace, 9"
                "$mainMod SHIFT, 0, movetoworkspace, 10"
                # Example special workspace (scratchpad)
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"
                # Scroll through existing workspaces with mainMod + scroll
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"
                # Screenshots of a region
                "$mainMod SHIFT, P, exec, $HOME/.config/scripts/screenshot"
            ];
            bindm = [
                # Move/resize windows with mainMod + LMB/RMB and dragging
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];
            bindel = [
                # Laptop multimedia keys for volume and LCD brightness
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ];
            bindl = [
                # Requires playerctl
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];
            ##############################
            ### WINDOWS AND WORKSPACES ###
            ##############################
            # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
            # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules
            #
            ##### Workspace rules
            workspace = [
                "1,monitor:DP-3,default:true"
                "2,monitor:DP-3"
                "3,monitor:DP-3"
                "4,monitor:DP-3"
                "5,monitor:DP-3"
                "6,monitor:DP-5,default:true"
                "7,monitor:DP-5"
                "8,monitor:DP-5"
                "9,monitor:DP-5"
                "10,monitor:DP-5"
            ];
            ###### Window rules
            windowrulev2 = [
                "workspace 1, class:firefox"
                "workspace 6, class:thunderbird"
                "workspace 7, class:Slack"
                "workspace 7, class:teams-for-linux"
                "workspace 2, class:emacs"
                "suppressevent maximize, class:.*"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            ];
        };
    };
}
