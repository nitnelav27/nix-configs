{ config, lib, pkgs, ... }:

{
    # Enable OpenGL
    hardware.graphics = {
        enable = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
        # Modesetting is required for Hyprland
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend issues.
        powerManagement.enable = false;
        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with nouveau)
        # This is generally recommended for newer cards (Turing and newer)
        open = true;

        # Enable the Nvidia settings menu,
	    # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Select the appropriate driver version for your GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}
