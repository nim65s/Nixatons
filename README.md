# Nixatons

## Prérequis

### Nix:

ubuntu 24.04: `sudo apt install nix-setup-systemd`
`sudo usermod -aG nix-users $USER`
`newgrp nix-users` # ou logout/login

** OU **

https://nixos.org/download/
```
$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Test: `nix run nixpkgs#hello`

### Flakes

`nix run --extra-experimental-features nix-command --extra-experimental-features flakes nixpkgs#hello`

https://github.com/NixOS/nixpkgs/

`ls /nix/store`
