{ config, pkgs, lib, inputs, ... }:

{
    programs.mpv = {
        enable = true;
        config = {
            vo = "gpu";
            gpu-context = "wayland";
            hwdec = "vaapi";
        };
    };
}
