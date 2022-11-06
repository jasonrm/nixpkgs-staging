{ stdenv, fetchFromGitHub, lib, gcc }:
stdenv.mkDerivation rec {
  pname = "radius-mac";
  version = "188b1dbf";

  src = fetchFromGitHub {
    owner = "carlanton";
    repo = pname;
    rev = "188b1dbff2853174163242808ff9ea004d7574d4";
    hash = "sha256-3kzmKXcmhlSc5i4qgjnz6PEz2xfAGSwaP61KZ78IkWA=";
    # sha256 = lib.fakeSha256;
  };

  buildInputs = [
    gcc
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp src/radius-mac $out/bin/$bin
  '';

  hardeningDisable = lib.optionals (stdenv.isAarch64 && stdenv.isDarwin) [ "stackprotector" ];

  meta = with lib; {
    homepage = "https://github.com/carlanton/radius-mac";
    description = "radius mac server";
    license = licenses.mit;
    platforms = with platforms; unix;
  };
}
