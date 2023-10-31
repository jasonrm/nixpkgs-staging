{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "hashname";
  version = "git-2023.06.22";

  src = fetchFromGitHub {
    owner = "xxkfqz";
    repo = pname;
    rev = "45dd605151ff37a01a9e2495c5e1b44c00b44ab8";
    hash = "sha256-rC+a5q8iF9guiobWr0G4fUXXt8oxl/sc3OToEcc6jSM=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-/cN3vHyHq/dKN4a/P8d2sICzI3Gp7qz+GyWn1N0qm7U=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Rename files to their hash";
    homepage = "https://github.com/xxkfqz/hashname";
    license = licenses.wtfpl;
    maintainer = ["jason@mcneil.dev"];
  };
}
