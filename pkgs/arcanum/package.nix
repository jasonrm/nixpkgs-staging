{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-U+qDh7n9jQZTUhaUWbtJlf5JBUDJHKMzgW87mB6tD4c=";
    # hash = lib.fakeHash;
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-jl23aHm/2i2cB8j6KrAeeNavmQQmaLdlGRK+A1HJz3s=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
