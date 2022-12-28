{ lib
, stdenv
, fetchFromGitHub
, git
, zlib
, zstd
, ncurses
}:
stdenv.mkDerivation rec {
  pname = "readsb";
  version = "3.14.1595";

  src = fetchFromGitHub {
    owner = "wiedehopf";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1iBCqRQIqRSiUuzzdr0GTg9f+ZUPoRs2ugy+R+F1SPM=";
    # hash = lib.fakeHash;
  };

  MODES_READSB_VERSION = version;

  installPhase = ''
    mkdir -p $out/bin
    cp readsb $out/bin/$bin
  '';

  nativeBuildInputs = [
    git
  ];

  buildInputs = [
    zlib
    zstd
    ncurses
  ];

  meta = with lib; {
    description = "ADS-B decoder swiss knife";
    homepage = "https://github.com/wiedehopf/readsb";
    platforms = platforms.linux;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
