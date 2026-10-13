{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "defmt";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "knurling-rs";
    repo = pname;
    fetchSubmodules = true;
    rev = "defmt-v${version}";
    hash = "sha256-hTn1mpKKnNPVGKFo71C4t6Ewv8rikQXWciSV0t8Ti78=";
  };

  doCheck = false;
  cargoBuildFlags = [
    "--bin"
    "defmt-print"
  ];

  cargoLock.lockFile = "${src}/Cargo.lock";

  meta = {
    homepage = "https://github.com/knurling-rs/${pname}";
    maintainer = ["jason@mcneil.dev"];
  };
}
