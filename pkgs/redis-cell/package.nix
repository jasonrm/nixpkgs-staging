{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "redis-cell";
  version = "v0.4.0";

  src = fetchFromGitHub {
    owner = "brandur";
    repo = pname;
    rev = version;
    sha256 = "sha256-CKdIbyuQlI8UDxVCh5sGO2Ll8h5DQjlkGiuE4SF2JyU=";
  };

  cargoHash = "sha256-48hIsQZdbF30jtlFkm2Ei+9uptmJD7IW+XRujf114mI=";

  meta = with lib; {
    description = "A Redis module that provides rate limiting in Redis as a single command.";
    license = licenses.mit;
    homepage = "https://github.com/brandur/redis-cell";
    maintainer = ["jason@mcneil.dev"];
  };
}
