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
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-YQJruQqQPzLzcv3+SW4/j7vUdJeZeZNjIOULJ31WrEE=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [ 
    # protobuf
    # pkg-config
  ];

  # buildNoDefaultFeatures = true;
  # buildFeatures = [ "rustls-tls-webpki-roots" ];

  buildInputs = [
    # openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  cargoHash = "sha256-8JsRWgjrlVlZRjsD/vU/rXUfEPcTJOcGhQx7P2Xmaf0=";
  # cargoHash = lib.fakeHash;

  # Some checks expect to a git repo
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
