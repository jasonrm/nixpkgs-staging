{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-tmpfiles";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-oXTIsFJslXDjBCNRE3X9vtQwfMNY8fLA4acaYfZRw/A=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-MDRtKcYnQQc6Sz6S81QycrDV7UruEaYBh+JOlT69qZY=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "A limited and simple implementation of systemd-tmpfiles in Rust";
    homepage = "https://github.com/jasonrm/systemd-tmpfiles";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
