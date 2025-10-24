{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nix }: let 
    
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    forEachSystem = nixpkgs.lib.genAttrs systems;

    overlayList = [ self.overlays.default ];

    pkgsBySystem = forEachSystem ( system:
      import nixpkgs {
        inherit system;
        overlays = overlayList;
      }
    );

  in rec {

    overlays.default = final: prev: {
      analogue-pocket-sync = final.callPackage ./package.nix {};
    };

    packages = forEachSystem ( system: {
      analogue-pocket-sync = pkgsBySystem.${system}.analogue-pocket-sync;
      default = pkgsBySystem.${system}.analogue-pocket-sync;
    });

    # nixosModules = import ./nixos-modules { overlays = overlayList; };      

  };
}
