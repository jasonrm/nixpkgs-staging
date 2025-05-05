{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "palantir-java-format";
  version = "2.63.0";
  binary = fetchurl {
    # https://repo1.maven.org/maven2/com/palantir/javaformat/palantir-java-format-native/2.63.0/palantir-java-format-native-2.63.0-nativeImage-macos_aarch64.bin
    url = "https://repo1.maven.org/maven2/com/palantir/javaformat/palantir-java-format-native/${version}/palantir-java-format-native-${version}-nativeImage-macos_aarch64.bin";
    hash = "sha256-13frqGqhP7izF14FhVfLFPKJzv9Lvc5DqVXjGdTjdJ4=";
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
