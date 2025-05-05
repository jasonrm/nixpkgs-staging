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
  pname = "dante-cli";
  version = "0.0.1+git";

  src = fetchFromGitHub {
    owner = "IRSMsoso";
    repo = pname;
    fetchSubmodules = true;
    rev = "704b5f0da2d9f2efe1c8eed79e82fdf229f83d3b";
    # hash = "sha256-3IXwXQWKd4GIPZc/vgkMgTrq7ACS2RWt598NVWLqnL4=";
    hash = lib.fakeHash;
  };

  # buildInputs = lib.optionals stdenv.isDarwin [
  #   darwin.apple_sdk.frameworks.SystemConfiguration
  # ];

  # cargoHash = "sha256-oFpFdT2VM41QR01Zjktb3uRS92GunCeVhNcLD8ZKE48=";
  cargoHash = lib.fakeHash;

  meta = with lib; {
    homepage = "https://github.com/IRSMsoso/dante-cli";
    maintainer = ["jason@mcneil.dev"];
  };
}
