{ overlays }:

{
  analogue-pocket-sync = import ./analogue-pocket-sync.nix;

  overlayNixpkgsForThisInstance =
    { pkgs, ... }:
    {
      nixpkgs = {
        inherit overlays;
      };
    };
}