{
  lib,
  fetchFromGitHub,
  rustPlatform,
  rust-bin,
  makeRustPlatform,
}:
let
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "AJenbo";
    repo = "phpantom_lsp";
    rev = version;
    hash = "sha256-0hhIlAOxBRmiyuvKS8nYWcarOXkOI1VRFqbSs/b4sGw=";
  };

  wasmToolchain = rust-bin.stable.latest.default.override {
    targets = [ "wasm32-wasip2" ];
  };

  wasmRustPlatform = makeRustPlatform {
    rustc = wasmToolchain;
    cargo = wasmToolchain;
  };

  zedExtension = wasmRustPlatform.buildRustPackage {
    pname = "phpantom-zed-extension";
    inherit version src;

    sourceRoot = "${src.name}/zed-extension";

    postPatch = ''
      cp ${./zed-extension-Cargo.lock} Cargo.lock
    '';

    cargoLock = {
      lockFile = ./zed-extension-Cargo.lock;
    };

    buildPhase = ''
      cargo build --release --target wasm32-wasip2
    '';

    installPhase = ''
      mkdir -p $out
      cp target/wasm32-wasip2/release/phpantom_zed.wasm $out/extension.wasm
    '';

    doCheck = false;
  };
in
rustPlatform.buildRustPackage rec {
  pname = "phpantom-lsp";
  inherit version src;

  cargoHash = "sha256-oRjXf1zR0Ajot6l6ljNAfT7o9yi8m9v8Iwc2xBlTxHM=";

  postInstall = ''
    mkdir -p $out/share/zed/extensions
    cp -r zed-extension $out/share/zed/extensions/phpantom
    cp ${zedExtension}/extension.wasm $out/share/zed/extensions/phpantom/extension.wasm
  '';

  meta = {
    description = "Fast PHP language server with deep type intelligence";
    homepage = "https://github.com/AJenbo/phpantom_lsp";
    license = lib.licenses.mit;
    maintainer = [ "jason@mcneil.dev" ];
    mainProgram = "phpantom_lsp";
  };
}
