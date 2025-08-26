{
  description = "un truc à propos de Nixatons";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = inputs:
  let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
    };
  in
  {
    packages = {
      x86_64-linux = {
        default = pkgs.hello;
      };
    };
  };


}
