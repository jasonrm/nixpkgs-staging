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
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-3IXwXQWKd4GIPZc/vgkMgTrq7ACS2RWt598NVWLqnL4=";
    # hash = lib.fakeHash;
  };

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  cargoHash = "sha256-oFpFdT2VM41QR01Zjktb3uRS92GunCeVhNcLD8ZKE48=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
