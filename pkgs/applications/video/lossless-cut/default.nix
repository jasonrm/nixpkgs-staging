{ stdenv
, fetchurl
, appimageTools
, makeWrapper
, electron_8
, gsettings-desktop-schemas
, gtk3
, unzip
, nodePackages
, ffmpeg
}:
let
  electron = electron_8;
in
stdenv.mkDerivation rec {
  pname = "lossless-cut";
  version = "3.30.0";

  src = fetchurl {
    url = "https://github.com/mifi/lossless-cut/releases/download/v${version}/LosslessCut-linux.AppImage";
    sha256 = "0gf9mnlfg2l00w41q9ria6s5f2s6d96hnzv143sw9l2gaqk4xwrh";
    name = "${pname}-${version}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    name = "${pname}-${version}";
    inherit src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    # runHook preInstall
    mkdir -p $out/bin $out/share/${pname} $out/share/applications
    ${nodePackages.asar}/bin/asar extract ${appimageContents}/resources/app.asar $out/share/${pname}/resources

    # FIXME: Strange issue where it thinks we're in dev?
    sed -i "s|require('electron-is-dev')|false|g" $out/share/${pname}/resources/build/electron.js

    # Not needed currently, but might in future
    # sed -i "s|window.process.resourcesPath|'$out/share/${pname}/resources'|g" $out/share/${pname}/resources/build/static/js/main.*.chunk.js

    # TODO: fix greedy sed syntax
    sed -i "s|T..ffmpeg..|'${ffmpeg}/bin/ffmpeg'|g" $out/share/${pname}/resources/build/static/js/main.*.chunk.js
    sed -i "s|T..ffprobe..|'${ffmpeg}/bin/ffprobe'|g" $out/share/${pname}/resources/build/static/js/main.*.chunk.js

    cp -a ${appimageContents}/locales $out/share/${pname}
    cp -a ${appimageContents}/losslesscut.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share
    substituteInPlace $out/share/applications/${pname}.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    # runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags "$out/share/${pname}/resources --without-update"
  '';

  meta = with stdenv.lib; {
    description = "The swiss army knife of lossless video/audio editing";
    homepage = "https://github.com/mifi/lossless-cut";
    license = licenses.mit;
    maintainer = ["jason@mcneil.dev"];
    platforms = [ "x86_64-linux" ];
  };
}
