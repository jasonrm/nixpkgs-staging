{
  stdenv,
  fetchurl,
  lib,
  makeWrapper,
  deno,
}:
stdenv.mkDerivation rec {
  pname = "silverbullet";
  version = "0.2.7";

  src = fetchurl {
    url = "https://github.com/silverbulletmd/${pname}/releases/download/${version}/${pname}.js";
    # hash = lib.fakeHash;
    hash = "sha256-r+JeA6OwciJtr/gDwfpYHaxCy0SXPMPs5BJTUN0rGGU=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${deno}/bin/deno $out/bin/silverbullet \
        --add-flags run \
        --add-flags "--allow-all" \
        --add-flags "--unstable" \
        --add-flags "--" \
        --add-flags $src
  '';

  meta = with lib; {
    homepage = "https://github.com/silverbulletmd/silverbullet";
    description = "An extensible, open source personal knowledge platform.";
    license = licenses.mit;
    platforms = with platforms; all;
  };
}
