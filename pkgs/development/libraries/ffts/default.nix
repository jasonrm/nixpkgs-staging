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
,libyamlcpp
,glew
# , vulkan
# , opencl
}:

stdenv.mkDerivation rec {
  pname = "ffts";
  version = "fe86885ecafd0d16eb122f3212403d1d5a86e24e";

  src = fetchFromGitHub {
    owner = "anthonix";
    repo = "ffts";
    rev = version;
    hash = "sha256-arBXkEbKGd0y6XpyynUSFQmNs7fndhEK7y1NNZI9MnI=";
    # hash = lib.fakeHash;
    # fetchSubmodules = true;
  };

  nativeBuildInputs = [
    # autoPatchelfHook
    cmake
    # pkg-config
    # cppunit
    # makeWrapper
  ];
  buildInputs = [
  # gtkmm3
  # glm
  # vulkan-headers
  # vulkan-loader
  # clfft
  # glew
  # libyamlcpp

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
    homepage = "https://github.com/anthonix/ffts.git";
    description = "The Fastest Fourier Transform in the South";
    license = licenses.gpl3;
    platforms = with platforms; linux;
  };
}
