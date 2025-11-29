{ config, lib, pkgs, inputs, ... }:

{
    programs.git = {
        enable = true;
        settings = {
            credential.helper = "store";
            user = {
                name = "Valentin Vergara Hidd";
                email = "valentinvergara@gmail.com";
            };
        };
    };
}
