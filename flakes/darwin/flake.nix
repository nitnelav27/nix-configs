{
    description = "Nix Global and Home configurations Only for MacOS";

    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        };
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
            #inputs.nixpkgs.follows = "nixpkgs";
        };
        mac-app-util = {
            url = "github:hraban/mac-app-util";
            inputs.cl-nix-lite.url = "github:r4v3n6101/cl-nix-lite/url-fix";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, nvf, mac-app-util, self, ... }:
    let
      mkDarwinHost = hostname: system: mainUser:
                #let
                #pkgs = import nixpkgs {
                #inherit system;
                #config.allowUnfree = true;
                #overlays = [
                #(final: prev: {
                #prettier = prev.nodePackages.prettier;
                #})
                #];
                #};
                #in
                nix-darwin.lib.darwinSystem {
                    inherit system;
                    pkgs = import nixpkgs {
                        system = system;
                        config = {
                            allowUnfree = true;
                        };
                    };
                    modules = [
                        ../../hosts/${hostname}/configuration.nix
                        home-manager.darwinModules.home-manager {
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users.${mainUser}.imports = [
                                    nvf.homeManagerModules.default
                                    mac-app-util.homeManagerModules.default
                                    #nixvim.homeManagerModules.nixvim
                                    ../../hosts/${hostname}/home.nix
                                ];
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
                                user = ${mainUser};

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
                mbpro = mkDarwinHost "mbpro" "aarch64-darwin" "vvh";
            };
            };
}
