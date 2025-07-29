{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "arcanum";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "bitnixdev";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-VjXytwoJX8MpUDylN384Gorok839Mf+GwO9jJmiLea8=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-DoBi0xd0JQ/a1H9U42hfWkugFUwXWc+EBgWWOMBxfNA=";

  meta = with lib; {
    homepage = "https://github.com/bitnixdev/arcanum";
    license = licenses.mit;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
