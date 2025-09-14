{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "systemd-tmpfiles";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-xorm4FkBW+ASSXjQ+Vr7Q2BlYeZEXU14sDZazMDdp7c=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-7PJZOuP//9fhE4y8N4Fo85pXgBG/L3LKcillXSyDdmk=";
  # cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "A limited and simple implementation of systemd-tmpfiles in Rust";
    homepage = "https://github.com/jasonrm/systemd-tmpfiles";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
  };
}
