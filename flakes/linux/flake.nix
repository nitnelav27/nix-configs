{
    description = "Nix Global and Home configurations. NixOS only";

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
        solaar = {
            #url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
            #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.3.tar.gz"; # uncomment line for solaar version 1.1.15
            url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, hyprland, nvf, solaar, self, ... }:
        let
            mkHost = hostname: system: mainUser: nixpkgs.lib.nixosSystem {
                inherit system;
                pkgs = import nixpkgs {
                    system = system;
                    config = {
                        allowUnfree = true;
                        nvidia.acceptLicense = true;
                        permittedInsecurePackages = [ "electron-36.9.5" ];
                    };
                };
                modules = [
                    ../../hosts/${hostname}/configuration.nix 
                    solaar.nixosModules.default
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
                specialArgs = { inherit hostname inputs; };
            };
            
        in {
            nixosConfigurations = {
                nixtop-ccp = mkHost "nixtop-ccp" "x86_64-linux" "vsvh";
                dockmedia = mkHost "dockmedia" "x86_64-linux" "docko";
		        rengo = mkHost "rengo" "x86_64-linux" "rengo";
                nixtest = mkHost "nixtest" "x86_64-linux" "dos";
                media-ccp = mkHost "media-ccp" "x86_64-linux" "vvh";
            };
        };
}
