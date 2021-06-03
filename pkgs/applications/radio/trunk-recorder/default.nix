{ stdenv
, lib
, fetchFromGitHub

, cmake
, cppunit
, pkg-config

, boost175
, curl
, fftw
, fftwFloat
, gmp
, gnuradio3_8Minimal
, gnuradio3_8Packages
, hackrf
, icu
, log4cpp
, mpir
, openssl
, uhd
, volk
}:

stdenv.mkDerivation rec {
  pname = "trunk-recorder";
  version = "3.3.7";

  src = fetchFromGitHub {
    owner = "robotastic";
    repo = "trunk-recorder";
    rev = "v${version}";
    sha256 = "1njjvl3gwkpzgr0ssyfz74yhdci4ghd40j34schw8r9k7d3jvfs7";
    # sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    cppunit
  ];
  buildInputs = [
    boost175
    curl
    fftw
    fftwFloat
    gmp
    gnuradio3_8Minimal
    gnuradio3_8Packages.osmosdr
    hackrf
    icu
    log4cpp
    mpir
    openssl
    uhd
    volk
  ];

  installPhase = ''
    runHook preInstall

    install -D -m 755 recorder $out/bin/recorder
    install -D -m 755 lib/op25_repeater/lib/libgnuradio-op25_repeater.so $out/usr/lib/libgnuradio-op25_repeater.so

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/robotastic/trunk-recorder";
    description = "Records calls from a Trunked Radio System (P25 & SmartNet)";
    license = licenses.gpl3;
    platforms = with platforms; linux;
  };
}
