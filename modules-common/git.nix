{ config, lib, pkgs, inputs, ... }:

{
        programs.git = {
                enable = true;
                userName = "Valentin Vergara Hidd";
                userEmail = "valentinvergara@gmail.com";
                extraConfig = {
                        credential.helper = "store";
                };
        };
}
