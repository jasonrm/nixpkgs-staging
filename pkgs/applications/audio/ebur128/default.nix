{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "ebur128";
  version = "0.1.10";

  src = fetchFromGitHub {
    owner = "sdroege";
    repo = pname;
    fetchSubmodules = true;
    rev = version;
    hash = "sha256-FN18HAeQbu38DVPvzGC6FFdOgsh61GtVR2eV8kdL5g4=";
    # hash = lib.fakeHash;
  };

  cargoPatches = [./cargo.patch];

  cargoBuildFlags = ["--example normalize"];

  cargoHash = "sha256-V17xrYCHM11K0bJ8c+5RhhDveASpE5VvavRfiufVzzk=";

  postInstall = let
    cargoTarget = rustPlatform.cargoInstallHook.targetSubdirectory;
  in ''
    install -D target/${cargoTarget}/release/examples/normalize $out/bin/normalize
  '';

  meta = {
    homepage = "https://github.com/sdroege/ebur128";
    maintainer = ["jason@mcneil.dev"];
  };
}
