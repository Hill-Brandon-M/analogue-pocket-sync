# Analogue Pocket-Sync Nix Flake Package

This repository contains a Nix package for Analogue Pocket-Sync, a GUI tool for managing your Analogue Pocket. The package uses Nix Flake to manage dependencies and simplify the installation process on various Linux distributions.

## Package Description

Analogue Pocket-Sync is a utility that allows users to interact with their Analogue Pocket devices through a graphical user interface. It provides features such as firmware updates, configuration management, and other essential functionalities for Analogue Pocket users. This package simplifies installing Analogue Pocket-Sync on systems running NixOS or other distributions supported by Nix.

## Installation

There are several methods for installation:

### Method 1: Direct Invocation
If `nix` is available on your system, you can run Analogue Pocket-Sync using the following command:
```bash
nix run github:Hill-Brandon-M/analogue-pocket-sync
```

### Method 2: Installation as a NixOS flake input
If you are running NixOS or another distribution supported by Nix with flakes enabled, you can install BrowserOS by adding this repository to your `flake.nix` in the following manner:
```nix
{
    # ...
    
    inputs.analogue-pocket-sync = {
        url = "github:Hill-Brandon-M/analogue-pocket-sync";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # ...
    
    outputs = { self, nixpkgs, analogue-pocket-sync, ... }:
       let
            inputModules = ({config, pkgs, ...}: {
                nixpkgs.overlays = [ 
                    analogue-pocket-sync.overlays.default 
                    # ... Other input overlays ...
                ];
            });
          
            # ...

       in {
            # ...

            nixosConfigurations = {
                
                # ...

                pc = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs nixpkgs;};
                    modules = [
                        inputModules
                        # ... Other configuration files ...
                    ];
                };
            
            };
        }
}

```
