{
  lib,
  fetchFromGitHub,
  rust-bin,
  makeRustPlatform,
}: let
  # Zed loads extensions as WASM components. Since Zed 0.x switched its
  # extension build to the `wasm32-wasip2` target (PR zed#30953), the component
  # is produced directly by `cargo build` with no preview1 adapter or
  # `wasm-tools component new` step — we just need a toolchain that has the
  # wasm32-wasip2 target, which rust-overlay provides.
  rustToolchain = rust-bin.stable.latest.minimal.override {
    targets = ["wasm32-wasip2"];
  };
  rustPlatform = makeRustPlatform {
    cargo = rustToolchain;
    rustc = rustToolchain;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "phpantom-zed";
    version = "0.9.0";

    src = fetchFromGitHub {
      owner = "PHPantom-dev";
      repo = "phpantom_lsp";
      rev = version;
      hash = "sha256-euWaFH40VHefZewUcKvsLwwHZP+GwfTN8kfuAkaABB8=";
    };

    # Only the Zed extension lives here; the rest of the repo is the LSP server
    # (packaged in nixpkgs as `phpantom-lsp`). cargoRoot points the vendoring /
    # lockfile hooks at the sub-crate.
    cargoRoot = "zed-extension";

    # Upstream gitignores Cargo.lock, so we carry our own generated lockfile and
    # drop it into the crate before the cargo-setup hook validates it (the hook
    # only checks consistency, it doesn't create a missing lockfile).
    cargoLock = {
      lockFile = ./Cargo.lock;
    };
    prePatch = ''
      cp ${./Cargo.lock} ${cargoRoot}/Cargo.lock
    '';

    # cdylib WASM target: no host binary, no tests to run.
    doCheck = false;

    buildPhase = ''
      runHook preBuild
      ( cd zed-extension && cargo build --release --frozen --offline --target wasm32-wasip2 )
      runHook postBuild
    '';

    # Lay out the directory exactly as Zed expects an installed extension:
    # <extensions>/installed/<id>/{extension.toml,extension.wasm}. Zed scans
    # `installed/` and regenerates its own index.json, so home-manager can
    # symlink this dir's contents into place (per-entry, recursive) without
    # any registration step. The id ("phpantom") comes from extension.toml.
    #
    # The wasm32-wasip2 target normalizes `-` to `_` in the crate output name
    # (crate is `phpantom-zed` -> `phpantom_zed.wasm`).
    installPhase = ''
      runHook preInstall

      dir="$out/share/zed/extensions/phpantom"
      install -Dm644 zed-extension/target/wasm32-wasip2/release/phpantom_zed.wasm "$dir/extension.wasm"
      install -Dm644 zed-extension/extension.toml "$dir/extension.toml"

      runHook postInstall
    '';

    meta = with lib; {
      description = "PHPantom Zed extension (PHP language support via the PHPantom LSP), prebuilt as a WASM component";
      homepage = "https://github.com/PHPantom-dev/phpantom_lsp";
      license = licenses.mit;
      maintainer = ["jason@mcneil.dev"];
      platforms = platforms.all;
    };
  }
