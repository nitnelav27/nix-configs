{
    description = "Raspberry Pi 5 configuration flake";
    
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixos-raspberrypi = {
            url = "github:nvmd/nixos-raspberrypi/main";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    nixConfig = {
        extra-substituters = [
            "https://nixos-raspberrypi.cachix.org"
        ];
        extra-trusted-public-keys = [
            "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        ];
    };

    outputs = { self, nixpkgs, nixos-raspberrypi, home-manager, nvf }@inputs:
        let 
        mkHost = hostname: system: mainUser: nixos-raspberrypi.lib.nixosSystem {
            specialArgs = inputs;
            modules = [
                ../../hosts/${hostname}/configuration.nix
                ({...}: {
                    imports = with nixos-raspberrypi.nixosModules; [
                        raspberry-pi-5.base
                        raspberry-pi-5.bluetooth
                    ];
                })
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.${mainUser}.imports = [
                            nvf.homeManagerModules.default
                            ../../hosts/${hostname}/home.nix
                        ];
                        extraSpecialArgs = { inherit inputs; };
                    };
                }
            ];
        };

    in {
            nixosConfigurations = {
                rpi-alx = mkHost "rpi-alx" "aarch64-linux" "vvh";
            };
        };
}

