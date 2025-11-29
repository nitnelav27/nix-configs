{ config, pkgs, lib, inputs, ... }: 
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        immediate_render = true;
        hide_cursor = false;
      };

      animation = [
        "inputFieldDots, 1, 2, linear"
        "fadeIn, 0"
      ];

      background = [
        {
          monitor = "";
          path = "~/pix/lock/light_door.png";
        }
      ];

      input-field = [
        {
          monitor = "";

          size = "500, 100";
          valign = "center";
                                        #position = "50%, 50%";

          outline_thickness = 6;

          font_color = "rgb(b6c4ff)";
          outer_color = "rgba(180, 180, 180, 0.5)";
          inner_color = "rgba(200, 200, 200, 0.1)";
          check_color = "rgba(247, 193, 19, 0.5)";
          fail_color = "rgba(255, 106, 134, 0.5)";
          font_family = "Fira Sans";

          fade_on_empty = false;
          placeholder_text = "Enter Password";

          dots_spacing = 0.2;
          dots_center = true;

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          color = "rgb(b6c4ff)";

          position = "0%, 30%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(b6c4ff)";

          position = "0%, 40%";

          valign = "center";
          halign = "center";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
      ];
    };
  };
}

