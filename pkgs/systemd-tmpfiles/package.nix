{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-tmpfiles";
  version = "0.2.5";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JQl4lHPW0hchYrZRcsqvPSrm7ebexHQI+bY7uTeTyeU=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-PYb6VCaQM8Umt+hEDpSe19SOOYnIAiDyuJVM69Ejudg=";

  meta = with lib; {
    description = "A limited and simple implementation of systemd-tmpfiles in Rust";
    homepage = "https://github.com/jasonrm/systemd-tmpfiles";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
