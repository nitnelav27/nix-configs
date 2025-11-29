{
  description = "Raspberry Pi 5 configuration flake";
    inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    };

  nixConfig = {
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  outputs = { self, nixpkgs, nixos-raspberrypi }@inputs:
    {
      nixosConfigurations = {
        rpi-alx = nixos-raspberrypi.lib.nixosSystem {
          specialArgs = inputs;
          modules = [
		./configuration.nix
            ({...}: {
              imports = with nixos-raspberrypi.nixosModules; [
                raspberry-pi-5.base
                raspberry-pi-5.bluetooth
              ];
            })
          ];
        };
      };
    };
}

