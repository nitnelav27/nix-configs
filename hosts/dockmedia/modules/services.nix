{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  services.openssh = {
                enable = true;
                ports = [ 1186 ];
                settings = {
                        PasswordAuthentication = false;
                };
        };
  services.nfs = {
                settings = {
                        nfsd.udp = false;
                        nfsd.vers3 = true;
                        nfsd.vers4 = true;
                };
                server = {
                        enable = true;
                        lockdPort = 4001;
                        mountdPort = 4002;
                        statdPort = 4000;
                        exports = ''
                                /export 10.27.81.115/32(insecure,rw,no_subtree_check,fsid=0) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check,fsid=0) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check,fsid=0)
                                ## decreto
                                /export/.decreto 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
                                ## calibre
                                /export/calibre 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
                                ## data
                                /export/data 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
                                ## dump
                                /export/dump 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
                                ## migration
                                /export/migration 10.27.81.115/32(insecure,rw,no_subtree_check)
                                ## docs
                                /export/docs 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.84/32(insecure,rw,no_subtree_check)
                                ## results
                                /export/results 10.27.81.115/32(insecure,rw,no_subtree_check) 10.27.81.81/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check) 10.27.81.82/32(insecure,rw,sync,all_squash,anonuid=1000,anongid=1000,no_subtree_check)
                        '';
                };
        };


  virtualisation.docker = {
                enable  = true;
        };
}
