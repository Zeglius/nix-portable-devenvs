{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nixForSystem = nixpkgs.lib.genAttrs (f: f) [];
    in
    {
      
      packages.${system}.default = 
        (pkgs.callPackage ./default.nix {  });
    };
}