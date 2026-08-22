{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mac-ocr";
  version = "1.1.1";

  src = fetchzip {
    url = "https://registry.npmjs.org/mac-ocr/-/mac-ocr-${finalAttrs.version}.tgz";
    hash = "sha256-6OEIrnn6bHFRdOIYkkhPRWlEMdfp1zK+IZD+3YYq/Qw=";
  };

  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 bin/mac-ocr $out/bin/mac-ocr

    runHook postInstall
  '';

  meta = {
    description = "macOS CLI for OCR and searchable PDFs using Apple's Vision framework";
    homepage = "https://github.com/privatenumber/mac-ocr";
    license = lib.licenses.mit;
    mainProgram = "mac-ocr";
    platforms = lib.platforms.darwin;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
