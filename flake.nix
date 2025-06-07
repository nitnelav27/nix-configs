{
        description = "Nix Global and Home configurations";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                nvf = {
                        url = "github:notashelf/nvf";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                hyprland.url = "github:hyprwm/Hyprland";
        };

        outputs = inputs@{ nixpkgs, home-manager, hyprland, nvf, ... }:
                let
                userAssignments = {
                        nixtop = [ "vsvh" ];
                        dockmedia = [ "docko" ];
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
        in {
                nixosConfigurations = {
                        nixtop = mkHost "nixtop" "x86_64-linux";
                        dockmedia = mkHost "dockmedia" "x86_64-linux";
                };
        };


        #        outputs = inputs@{ nixpkgs, home-manager, nvf, hyprland, ... }: {
        #                nixosConfigurations = {
        #                        dockmedia = nixpkgs.lib.nixosSystem {
        #                                system = "x86_64-linux";
        #                                modules = [
        #                                        ./system/configuration.nix
        #                                        nvf.nixosModules.default
        #                                        home-manager.nixosModules.home-manager {
        #                                                home-manager.useGlobalPkgs = true;
        #                                                home-manager.useUserPackages = true;
        #                                                home-manager.users.docko = {
        #                                                        imports = [
        #                                                                nvf.homeManagerModules.default
        #                                                                ./home/home.nix     
        #                                                        ];
        #                                                };
        #                                        }
        #                                ];
        #                        };
        #                };
        #        };
}
