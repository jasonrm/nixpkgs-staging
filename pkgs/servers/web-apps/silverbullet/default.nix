{
  stdenv,
  fetchurl,
  lib,
  makeWrapper,
  deno,
}:
stdenv.mkDerivation rec {
  pname = "silverbullet";
  version = "0.5.8";

  src = fetchurl {
    url = "https://github.com/silverbulletmd/${pname}/releases/download/${version}/${pname}.js";
    # hash = lib.fakeHash;
    hash = "sha256-p6ErwshY/Bq7jMumSFiqjl10VBZtW8RgrMuChn2yCYc=";
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
