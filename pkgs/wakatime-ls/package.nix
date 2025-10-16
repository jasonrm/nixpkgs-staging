{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "wakatime-ls";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "mrnossiom";
    repo = "wakatime-ls";
    rev = "v${version}";
    hash = "sha256-rNmHn8SgJJ/MLOwN/PoSFeVf4jfL5Qj2yJ+HcfjMZIk=";
  };

  cargoHash = "sha256-iOy61VEOgLzstcL44WEqB62J9Nmmg6UoKIGZyG1f4BA=";

  meta = with lib; {
    description = "A dead-simple language server around wakatime-cli to send code tracking heartbeats";
    homepage = "https://github.com/mrnossiom/wakatime-ls";
    license = licenses.cecill21;
  };
}
