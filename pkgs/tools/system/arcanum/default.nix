{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  protobuf,
  pkg-config,
  stdenv,
  darwin,
  gcc
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-jwEqA/cPIEpmoNpZ/sUU/B+9BLIOeBJDFq0OfTiQzP0=";
    # hash = lib.fakeHash;
  };

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  cargoHash = "sha256-X3y3bEFJ/UNU7aiZFZoCcd/V/wrDoQ5tNLwMfYPXRR4=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
