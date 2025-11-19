{ config, lib, pkgs, inputs, ... }:

{
    services.paperless = {
        enable = true;
        mediaDir = "/storage/docs/paperless";
        consumptionDir = "/storage/docs/GMU/research/to_read";
        consumptionDirIsPublic = true;
        address = "0.0.0.0";
        port = 28981;
        user = "dos";
    };
}
