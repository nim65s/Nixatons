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
    {
      packages.${system} = {
        default = pkgs.hello;
        # celui la va pas compiler: `nix run -L .#hello-broken`
        hello-broken = pkgs.hello.overrideAttrs {
          env.NIX_CFLAGS_COMPILE = "-toto";
        };
      };
    };

}
