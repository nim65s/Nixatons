{
  description = "un truc à propos de Nixatons";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
    in
    rec {
      nixosConfigurations.pikachu = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          "${inputs.nixpkgs}/nixos/modules/virtualisation/qemu-vm.nix"
          (
            {
              config,
              pkgs,
              lib,
              ...
            }:
            {
              networking.hostName = "pikachu";
              time.timeZone = "Europe/Paris";
              i18n.defaultLocale = "fr_FR.UTF-8";
              console.keyMap = "fr";

              users.users.moi = {
                isNormalUser = true;
                initialPassword = "pipo";
                extraGroups = [ "wheel" ];
              };
              security.sudo.wheelNeedsPassword = false;
              services.qemuGuest.enable = true;
              networking.networkmanager.enable = true;
              programs = {
                vim.enable = true;
                git.enable = true;
                sway = {
                  enable = true;
                  extraSessionCommands = ''
                    export XKB_DEFAULT_LAYOUT=fr
                    export XKB_DEFAULT_VARIANT=ergol
                  '';
                };
              };
              environment.systemPackages = [
                pkgs.hello
                pkgs.ponysay
                pkgs.kitty
              ];
              boot.loader.grub.enable = false;
              boot.loader.systemd-boot.enable = false;

              virtualisation = {
                memorySize = 8182;
                cores = 2;
                diskSize = 8192;
                graphics = true;
                qemu.options = [
                  "-device"
                  "virtio-vga"
                ];
                spiceUSBRedirection.enable = true;
              };
              system.stateVersion = "25.05";
            }
          )
        ];
      };
      packages.${system} = {
        default = pkgs.hello;
        # celui la va pas compiler: `nix run -L .#hello-broken`
        hello-broken = pkgs.hello.overrideAttrs {
          env.NIX_CFLAGS_COMPILE = "-toto";
        };
        pikachu = nixosConfigurations.pikachu.config.system.build.vm;
      };
    };

}
