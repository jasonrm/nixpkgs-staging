{ lib
, stdenv
, fetchFromGitHub
, gcc
}:
stdenv.mkDerivation rec {
  pname = "rnd64";
  version = "v0.41";

  src = fetchFromGitHub {
    owner = "Tinram";
    repo = "RND64";
    rev = version;
    hash = "sha256-cfvWr5ZO4CAZVqZTdf+eF2j9cV1XK5B1x91DwtUGsAo=";
  };

  CFLAGS = [
    # Ignore warning/error
    "-Werror=stringop-overflow=0"

    # From makefile
    "-O3"
    "-Wall"
    "-Wextra"
    "-Wuninitialized"
    "-Wunused"
    "-Werror"
    "-Wformat=2"
    "-Wunused-parameter"
    "-Wshadow"
    "-Wwrite-strings"
    "-Wstrict-prototypes"
    "-Wold-style-definition"
    "-Wredundant-decls"
    "-Wnested-externs"
    "-Wmissing-include-dirs"
    "-Wformat-security"
    "-std=gnu99"
    "-flto"
    "-s"
  ];

  buildPhase = ''
    cd src
    $CC $CFLAGS -c -o rnd64.o rnd64.c
    $CC $CFLAGS rnd64.o -lpthread -O3 -o ../bin/rnd64
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/rnd64 $out/bin/
  '';

  buildInputs = [
    gcc
  ];

  meta = with lib; {
    description = "fast multi-threaded data generator";
    license = licenses.gpl3;
    homepage = "https://github.com/Tinram/RND64";
    platforms = platforms.linux;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
