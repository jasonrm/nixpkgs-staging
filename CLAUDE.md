# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix flake providing a custom package set ("staging" packages not yet in nixpkgs or with custom patches). It exposes packages via `legacyPackages`, a NixOS module, and an overlay.

## Version Control

This repo uses **Jujutsu (`jj`)** instead of `git` for day-to-day work. Use `jj` commands rather than `git` commands.

New files must be tracked before `nix build` can see them (flakes only see tracked files). Run any `jj` command (e.g. `jj status`) to snapshot the working copy and auto-track new files before building.

## Build Commands

```bash
# Build a specific package
nix build .#<package_name>

# Update flake inputs
nix flake update
```

When a hash (e.g. `hash`, `vendorHash`, `cargoHash`) is not yet known, use an empty string `""`, then run `nix build .#<package_name>` to get the actual hash from the error output.

## Architecture

### Package System (`pkgs/`)

Each package lives in `pkgs/<name>/package.nix`. The system auto-discovers all `package.nix` files recursively via `pkgs/default.nix`.

`pkgs/default.nix` uses `makeExtensible` to create a self-referential package set. Each package function receives only the arguments it declares (via `functionArgs` introspection + `intersectAttrs`), drawn from the merged set of `pkgs` and the package set itself. This means packages in this repo can depend on each other by simply declaring them as function arguments.

### Adding a New Package

1. Create `pkgs/<name>/package.nix` with a standard nixpkgs-style package function
2. The function arguments are auto-filtered — only declare what you need (e.g. `{ lib, buildGoModule, fetchFromGitHub }:`)
3. Run `jj status` (or any `jj` command) to snapshot and track new files before building

### Flake Outputs

- `legacyPackages.<system>.*` — all packages for each system
- `overlays.default` — overlay adding all packages to a nixpkgs instance
- `nixosModules.default` — applies the overlay and imports all NixOS modules from `nixosModules/`

### Other Directories

- `nixosModules/services/` — NixOS service module definitions
- `pkgs/lib/` — custom helpers (e.g. `aliasToPackage` for creating shell script aliases)
- `node-packages/` — node2nix generated files (dev shell includes `node2nix`)
