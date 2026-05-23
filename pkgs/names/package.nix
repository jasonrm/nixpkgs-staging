{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "names";
  version = "v0.14.0";

  src = fetchFromGitHub {
    owner = "fnichol";
    repo = pname;
    rev = version;
    hash = "sha256-C0JEVTOgxtgvCgSSdYxMCMtAVRU1A7DEczNj4zY8q20=";
  };

  cargoHash = "sha256-+zNlzo/+CCGzxreDdCj/bjF28euFGuXJspJoBPaG+8E=";

  nativeBuildInputs = [
    pkg-config
  ];

  meta = with lib; {
    description = "Random name generator";
    homepage = "https://github.com/fnichol/names";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
