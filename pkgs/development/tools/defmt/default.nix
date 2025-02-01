{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "defmt";
  version = "0.3.10";

  src = fetchFromGitHub {
    owner = "knurling-rs";
    repo = pname;
    fetchSubmodules = true;
    rev = "defmt-v${version}";
    hash = "sha256-WmfvJEuMYrwlrrLzyZSTIiOgKE43dgOdrf5mfMVNljI=";
    # hash = lib.fakeHash;
  };

  # buildInputs = lib.optionals stdenv.isDarwin [
  #   darwin.apple_sdk.frameworks.SystemConfiguration
  # ];

  # cargoHash = "sha256-Wr67t+jKmcwmFmOGrsgAgeQsEQ1P0XAENekZmXFbk8g=";
  # cargoHash = lib.fakeHash;

  doCheck = false;
  cargoBuildFlags = ["--bin" "defmt-print"];

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = {
    homepage = "https://github.com/knurling-rs/${pname}";
    maintainer = ["jason@mcneil.dev"];
  };
}
