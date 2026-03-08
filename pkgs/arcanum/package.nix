{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-lOsFLfHQZM6CPh6Q/LhYvDJyziM0mWLioSi5TfChnuc=";
  };

  cargoHash = "sha256-fK61RTY96nPvk6GF4E5bZ8HfBZLmt1rwnkuRbW+hTeQ=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
