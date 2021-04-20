{ stdenv, lib
, fetchurl
, libarchive
, unzip
, autoPatchelfHook
}:
let

in stdenv.mkDerivation rec {
  name = "intelmas";
  version = "1.7";

  intelDownloadId = "30379";

  src = fetchurl {
    name = "intel-mas-src-${version}";
    url = "https://downloadmirror.intel.com/${intelDownloadId}/eng/Intel%C2%AE_MAS_CLI_Tool_Linux_${version}.zip";
    hash = "sha256-hysXnHbS2Sy+Pckc5dHSk5kqpkGqFYfsunwmO4g/eaI=";
  };

  nativeBuildInputs = [
    unzip
    libarchive
    autoPatchelfHook
  ];

  buildInputs = [
  ];

  unpackPhase = ''
    unzip $src
    bsdtar -x -f intelmas-*.x86_64.rpm
  '';

  installPhase = ''
    mkdir $out
    cp -r usr $out/
  '';

  meta = with lib; {
    homepage = "https://downloadcenter.intel.com/download/30379/Intel-Memory-and-Storage-Tool-CLI-Command-Line-Interface-";
    description = "Drive management tool for Intel SSDs and Intel Optane Memory devices";
    platforms = platforms.linux;
    # maintainers = with maintainers; [ makefu ];
  };
}