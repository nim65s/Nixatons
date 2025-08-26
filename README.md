# Nixatons

## Prérequis

- Nix:

ubuntu 24.04: `sudo apt install nix-setup-systemd`
`sudo usermod -aG nix-users $USER`

** OU **

https://nixos.org/download/
```
$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Test: `nix run nixpkgs#hello`
