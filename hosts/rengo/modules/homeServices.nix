{ config, lib, pkgs, inputs, ... }: 
{
        services = {
                cliphist = {
                        enable = true;
                        extraOptions = [
                                "-max-items" "1000"
                                "-max-dedupe-search" "20"
                        ];
                };
        };
}
