{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  nodejs,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "anydoc";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "firecrawl";
    repo = "anydoc";
    rev = "v${version}";
    hash = "sha256-UpTGSxLk0uUdo4xndgNptI8TLBywQoB0WTu9vDRDINU=";
  };

  cargoLock.lockFile = "${src}/Cargo.lock";

  cargoBuildFlags = [
    "--package"
    "anydoc-node"
  ];

  nativeBuildInputs = [makeWrapper];

  doCheck = false;

  installPhase = ''
    runHook preInstall

    install -Dm755 \
      target/*/release/libanydoc_node${stdenv.hostPlatform.extensions.sharedLibrary} \
      $out/lib/anydoc.node
    install -Dm644 node/{index.js,package.json} -t $out/share/anydoc
    install -Dm755 node/cli.js $out/share/anydoc/cli.js

    makeWrapper ${nodejs}/bin/node $out/bin/anydoc \
      --add-flags $out/share/anydoc/cli.js \
      --set NAPI_RS_NATIVE_LIBRARY_PATH $out/lib/anydoc.node

    runHook postInstall
  '';

  meta = {
    description = "Convert documents to GitHub-Flavored Markdown";
    homepage = "https://github.com/firecrawl/anydoc";
    license = lib.licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    mainProgram = "anydoc";
    platforms = lib.platforms.unix;
  };
}
