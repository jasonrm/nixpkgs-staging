{ stdenv
, lib
, fetchFromGitHub

, autoPatchelfHook
, cmake
, cppunit
, pkg-config
, makeWrapper

, gtkmm3
, glm
, vulkan-headers
, vulkan-loader
, clfft
, libyamlcpp
, glew
, ffts
, shaderc
, pcre
, opencl-clhpp
, ocl-icd
# , vulkan
# , opencl
}:

stdenv.mkDerivation rec {
  pname = "glscopeclient";
  version = "3bc6b5f29650c555a83cbe3dfbb39e3d00467496";

  src = fetchFromGitHub {
    owner = "glscopeclient";
    repo = "scopehal-apps";
    rev = version;
    hash = "sha256-NdH2EOu9OWfGReu0r4tpUW5jaVpJr/y8Vn8HcUnf/zo=";
    # hash = lib.fakeHash;
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    # autoPatchelfHook
    cmake
    pkg-config
    shaderc
    # cppunit
    # makeWrapper
  ];
  buildInputs = [
  gtkmm3
  glm
  pcre
  vulkan-headers
  vulkan-loader
  clfft
  glew
  libyamlcpp
  ffts
  opencl-clhpp
  ocl-icd
  # vulkan
  # opencl
    # thrift
    # spdlog
    # boost177
    # curl
    # fftw
    # fftwFloat
    # gmp
    # gnuradio3_8Minimal
    # gnuradio3_8.pkgs.osmosdr
    # hackrf
    # icu
    # log4cpp
    # mpir
    # openssl
    # uhd
    # volk
  ];

  # installPhase = ''
  #   runHook preInstall

  #   install -D -m 755 trunk-recorder $out/bin/trunk-recorder
  #   for LIB in libbroadcastify_uploader.so libgnuradio-op25_repeater.so libopenmhz_uploader.so librdioscanner_uploader.so libsimplestream.so libstat_socket.so libunit_script.so; do
  #     install -D -m 755 $LIB $out/usr/lib/$LIB
  #   done

  #   runHook postInstall
  # '';

  # postInstall = ''
  #   wrapProgram $out/bin/trunk-recorder \
  #     --prefix PATH ":" "${sox}/bin:${fdk-aac-encoder}/bin"
  # '';

  meta = with lib; {
    homepage = "https://github.com/glscopeclient/scopehal-apps";
    description = "signal analysis tool for oscilloscopes and logic analyzers";
    license = licenses.gpl3;
    platforms = with platforms; linux;
  };
}
