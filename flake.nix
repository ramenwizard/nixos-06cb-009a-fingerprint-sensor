{
  description = "Provides packages, modules and functions for the 06cb:009a fingerprint sensor.";

  inputs = {
    nixpkgs2311 = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
  };

  outputs = {
    self,
    nixpkgs2311,
    ...
  }: let
    pkgs = import nixpkgs2311 { system = "x86_64-linux"; };
    localPackages = import ./pkgs/default.nix { pkgs = pkgs; };
  in {
    nixosModules.python-validity = { config, lib, ... }: import ./modules/python-validity { config = config; lib = lib; localPackages = localPackages; };
    nixosModules.open-fprintd = { config, lib, ... }: import ./modules/open-fprintd { config = config; lib = lib; localPackages = localPackages; };

    localPackages = localPackages;

    lib = import ./lib {
      pkgs = pkgs;
      localPackages = localPackages;
    };
  };
}
