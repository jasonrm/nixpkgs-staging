{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "cargo-vcpkg";
  version = "0.1.7-2";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = pname;
    fetchSubmodules = true;
    rev = "cc9ef54b4334f259bb606c62452f07aca211806b";
    hash = "sha256-4b852tbGc4WISK7m14HNU4/zex+Dq9qUJxsWESmnweE=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-Wr67t+jKmcwmFmOGrsgAgeQsEQ1P0XAENekZmXFbk8g=";
  # cargoHash = lib.fakeHash;

  meta = {
    homepage = "https://github.com/mcgoo/${pname}";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
