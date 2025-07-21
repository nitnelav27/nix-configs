{
    description = "Nix Global and Home configurations Only for MacOS";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
        #nvf = {
        #    url = "github:notashelf/nvf";
        #    inputs.nixpkgs.follows = "nixpkgs";
        #};
	nixvim = {
  	   url = "github:nix-community/nixvim";
	   inputs.nixpkgs.follows = "nixpkgs";
	};
    };

    outputs = inputs@{ nixpkgs, home-manager, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, nixvim, self, ... }:
        let
            userAssignments = {
                nixtop = [ "vsvh" ];
                dockmedia = [ "docko" ];
                mbpro = [ "vvh" ];
            };
            
            mkDarwinHost = hostname: system: nix-darwin.lib.darwinSystem {
                inherit system;
                modules = [
                    ../hosts/${hostname}/configuration.nix
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
                                        nixvim.homeManagerModules.nixvim
                                        ../users/${user}/home.nix
                                    ];
                                };
                                }) assignedUsers);
                            extraSpecialArgs = { inherit inputs; };
                        };
                    }
                    {
                        environment.variables.MACOS_DEPLOYEMENT_TARGET = "15.5";
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
            darwinConfigurations = {
                mbpro = mkDarwinHost "mbpro" "aarch64-darwin";
            };
        };
}
