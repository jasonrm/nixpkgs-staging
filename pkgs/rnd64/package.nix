{
  lib,
  stdenv,
  fetchFromGitHub,
  gcc,
}:
stdenv.mkDerivation rec {
  pname = "rnd64";
  version = "v0.42";

  src = fetchFromGitHub {
    owner = "Tinram";
    repo = "RND64";
    rev = version;
    hash = "sha256-i5P9PzgU4y3WzInUmoc7wm9S72N32WYO3LezQYZ1jnE=";
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
    maintainer = ["jason@mcneil.dev"];
  };
}
