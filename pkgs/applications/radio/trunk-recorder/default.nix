{
  stdenv,
  lib,
  fetchFromGitHub,
  autoPatchelfHook,
  cmake,
  cppunit,
  pkg-config,
  makeWrapper,
  boost177,
  curl,
  fftw,
  fftwFloat,
  gmp,
  gnuradio3_8Minimal,
  gnuradio3_8,
  hackrf,
  icu,
  log4cpp,
  mpir,
  openssl,
  uhd,
  volk,
  spdlog,
  thrift,
  sox,
  fdk-aac-encoder,
}:
stdenv.mkDerivation rec {
  pname = "trunk-recorder";
  version = "4.3.2";

  src = fetchFromGitHub {
    owner = "robotastic";
    repo = "trunk-recorder";
    rev = "v${version}";
    hash = "sha256-E7mjnzVaujxlCklrRqtVU8MGNflf6I2aAES9pYPnvsQ=";
    # hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    cmake
    pkg-config
    cppunit
    makeWrapper
  ];
  buildInputs = [
    thrift
    spdlog
    boost177
    curl
    fftw
    fftwFloat
    gmp
    gnuradio3_8Minimal
    gnuradio3_8.pkgs.osmosdr
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

    install -D -m 755 trunk-recorder $out/bin/trunk-recorder
    for LIB in libbroadcastify_uploader.so libgnuradio-op25_repeater.so libopenmhz_uploader.so librdioscanner_uploader.so libsimplestream.so libstat_socket.so libunit_script.so; do
      install -D -m 755 $LIB $out/usr/lib/$LIB
    done

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/trunk-recorder \
      --prefix PATH ":" "${sox}/bin:${fdk-aac-encoder}/bin"
  '';

  meta = with lib; {
    homepage = "https://github.com/robotastic/trunk-recorder";
    description = "Records calls from a Trunked Radio System (P25 & SmartNet)";
    license = licenses.gpl3;
    platforms = with platforms; linux;
  };
}
