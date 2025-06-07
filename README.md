# NixOS Configurations

Clone this repository into `~/.config`. Mostly for consistency, since it does not make a difference. In order to maintain an installation:

1. Assuming the repository is cloned. In case it is not, use
```zsh
git clone git@github.com:nitnelav27/nix-configs.git ~/.config/nixdots
```

2. In the directory `~/.config/nixdots`, update the flake 
```zsh
sudo nix flake update
```

3. Rebuild both the system and home-manager installations 
```zsh
sudo nixos-rebuild switch --flake ~/.config/nixdots/#<hostname>
```
make sure to replace `<hostname>` with the hostname of the computer currently in use.
