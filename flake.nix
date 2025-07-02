{
    description = "Nix Global and Home configurations";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-homebrew.url = "github:zhaofengli/nix-homebrew";

        # Optional: Declarative tap management
        homebrew-core = {
            url = "github:homebrew/homebrew-core";
            flake = false;
        };
        homebrew-cask = {
            url = "github:homebrew/homebrew-cask";
            flake = false;
        };
        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = inputs@{ nixpkgs, home-manager, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, hyprland, nvf, ... }:
        let
            userAssignments = {
                nixtop = [ "vsvh" ];
                dockmedia = [ "docko" ];
                mbpro = [ "vvh" ];
            };
            
            mkHost = hostname: system: nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./hosts/${hostname}/configuration.nix 
                    ./hosts/${hostname}/hardware-configuration.nix 
                    home-manager.nixosModules.home-manager {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users = let 
                                assignedUsers = userAssignments.${hostname};
                                in builtins.listToAttrs
                            (map (user: {
                                name = user;
                                value = {
                                    imports = [
                                        nvf.homeManagerModules.default
                                        ./users/${user}/home.nix
                                    ];
                                };
                                }) assignedUsers);
                            extraSpecialArgs = { inherit inputs; };
                        };
                    }
                ];
                specialArgs = { inherit hostname inputs; };
            };

            mkDarwinHost = hostname: system: nix-darwin.lib.darwinSystem {
                inherit system;
                modules = [
                    ./hosts/${hostname}/configuration.nix
                    home-manager.darwinModules.home-manager {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            users = let
                                assignedUsers = userAssignments.${hostname};
                                in builtins.listToAttrs
                            (map (user: {
                                name = user;
                                value = {
                                    imports = [
                                        nvf.homeManagerModules.default
                                        ./users/${user}/home.nix
                                    ];
                                };
                                }) assignedUsers);
                            extraSpecialArgs = { inherit inputs; };
                        };
                    }
                    nix-homebrew.darwinModules.nix-homebrew {
                        nix-homebrew = {
                            # Install Homebrew under the default prefix
                            enable = true;

                            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                            enableRosetta = true;

                            # User owning the Homebrew prefix
                            user = "vvh";

                            # Optional: Declarative tap management
                            taps = {
                                "homebrew/homebrew-core" = homebrew-core;
                                "homebrew/homebrew-cask" = homebrew-cask;
                            };

                            # Optional: Enable fully-declarative tap management
                            # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
                            mutableTaps = false;
                        };
                    }
                ];
                specialArgs = { inherit hostname inputs; };
            };

        in {
            nixosConfigurations = {
                nixtop = mkHost "nixtop" "x86_64-linux";
                dockmedia = mkHost "dockmedia" "x86_64-linux";
            };
            darwinConfigurations = {
                mbpro = mkDarwinHost "mbpro" "aarch64-darwin";
            };
        };
}
