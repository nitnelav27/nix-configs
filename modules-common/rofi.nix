{ config, lib, pkgs, inputs, ... }:

{
        programs.rofi = {
                enable = true;
                package = pkgs.rofi-wayland;
                cyce = true;
                font = "Fira Sans 15";
                extraConfig = {
                        modi = "drun,filebrowser,window,run";
                        show-icons = true;
                        icon-theme = "Paper";
                        display-window = "  ";
                        display-run =  " ";
	                display-drun =  " ";
	                display-filebrowser = "  ";
                        drun-display-format = "{name}";
                        hover-select = false;
                        scroll-method = 1;
                        me-select-entry = "";
                        me-accept-entry = "MousePrimary";
                        window-format = "{w} · {c} · {t}";
                };
        };
}
