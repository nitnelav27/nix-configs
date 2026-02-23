{ config, pkgs, lib, inputs, ... }: 
{
    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                disable_loading = true;
                immediate_render = true;
                hide_cursor = false;
            };

            background = [
                {
                    path = "~/pix/lock/light_door.png";
                    color = "rgba(25, 20, 20, 1.0)";
                    blur_passes = 2; # 0 disables blurring
                    blur_size = 7;
                    noise = 0.0117;
                    contrast = 0.8916;
                    brightness = 0.8172;
                    vibrancy = 0.1696;
                    vibrancy_darkness = 0.0;
                }
            ];

            input-field = [
                {
                    monitor = "";
                    size = "200, 50";
                    outline_thickness = 3;
                    dots_size = 0.33; 
                    dots_spacing = 0.15;
                    dots_center = true;
                    outer_color = "rgb(151515)";
                    inner_color = "rgb(200, 200, 200)";
                    font_color = "rgb(10, 10, 10)";
                    fade_on_empty = true;
                    placeholder_text = "<i>Input Password...</i>";
                    hide_input = false;
                    position = "0, -20";
                    halign = "center";
                    valign = "center";        }
            ];

            label = [
                {
                    monitor = "";
                    text = "$TIME"; # Display current time
                    color = "rgba(200, 200, 200, 1.0)";
                    font_size = 64;
                    font_family = "Noto Sans";
                    position = "0, 80";
                    halign = "center";
                    valign = "center";
                }
            ];
        };
    };

    services.hypridle = {
        enable = true;
        settings = {
            general = {
                after_sleep_cmd = "hyprctl dispatch dpms on";
                before_sleep_cmd = "loginctl lock-session";
                lock_cmd = "pidof hyprlock || hyprlock";
            };

            listener = [
                {
                    timeout = 300; # 5 mins
                    on-timeout = "loginctl lock-session";
                }
                {
                    timeout = 330; # 5.5 mins
                    on-timeout = "hyprctl dispatch dpms off";
                    on-resume = "hyprctl dispatch dpms on";
                }
            ];
        };
    };
}
