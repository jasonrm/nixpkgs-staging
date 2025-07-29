{
  lib,
  fetchFromGitHub,
  rustPlatform,
  zlib,
  pkg-config,
  git,
  jujutsu,

}:
rustPlatform.buildRustPackage rec {
  pname = "jj-spr";
  version = "git-8f2eb88a";

  src = fetchFromGitHub {
    owner = "LucioFranco";
    repo = pname;
    fetchSubmodules = true;
    rev = "8f2eb88a4fae08784cba4c0d72ff22eab348822f";
    hash = "sha256-I51IGIQ5J7xv5SU+BVafQQv0mocCgSwliElZuhlL0lY=";
  };

  cargoHash = "sha256-bAWDwWSZWeegeJ7DY/PyCWQ9oYMn9A+PLAGkkmwzd8A=";

  buildInputs = [ zlib ];

  nativeBuildInputs = [
    pkg-config
    git
    jujutsu
  ];

  meta = {
    homepage = "https://github.com/LucioFranco/${pname}";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
