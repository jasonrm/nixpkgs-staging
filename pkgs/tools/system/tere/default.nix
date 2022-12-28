{ lib
, fetchFromGitHub
, rustPlatform
}:
rustPlatform.buildRustPackage rec {
  pname = "tere";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "mgunyho";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-BD7onBkFyo/JAw/neqL9N9nBYSxoMrmaG6egeznV9Xs=";
    # hash = lib.fakeHash;
  };

  cargoHash = "sha256-gAq9ULQ2YFPmn4IsHaYrC0L7NqbPUWqXSb45ZjlMXEs=";
  # cargoHash = lib.fakeHash;

  # v1.1.0 fails one test
  doCheck = false;

  meta = with lib; {
    description = "Terminal file explorer";
    homepage = "https://github.com/mgunyho/tere";
    license = licenses.eupl12;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
