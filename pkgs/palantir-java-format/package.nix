{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "palantir-java-format";
  version = "2.67.0";
  binary = fetchurl {
    # https://repo1.maven.org/maven2/com/palantir/javaformat/palantir-java-format-native/2.63.0/palantir-java-format-native-2.63.0-nativeImage-macos_aarch64.bin
    url = "https://repo1.maven.org/maven2/com/palantir/javaformat/palantir-java-format-native/${version}/palantir-java-format-native-${version}-nativeImage-macos_aarch64.bin";
    hash = "sha256-q4mf8HXr32UWnwnhdc6K7i4Podo1HBhGc1lXQ0hXuv0=";
    # hash = lib.fakeHash;
  };
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    install -Dm755 $binary $out/bin/palantir-java-format
  '';
  meta = {
    description = "A modern, lambda-friendly, 120 character Java formatter.";
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    license = lib.licenses.asl20;
    platforms = lib.platforms.darwin;
    homepage = "https://github.com/palantir/palantir-java-format";
  };
}
