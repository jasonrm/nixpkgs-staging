{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-tmpfiles";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-4r9idEzl5nIRAsQGPgLhqnZ5ypDyRt8oQMhBCNVuoU0=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-jK0V6cofQKV+nPLenFfBPyxNq/uu3J72ur8LMH/nwLI=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "A limited and simple implementation of systemd-tmpfiles in Rust";
    homepage = "https://github.com/jasonrm/systemd-tmpfiles";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
