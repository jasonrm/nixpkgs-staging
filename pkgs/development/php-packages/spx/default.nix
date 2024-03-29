{
  buildPecl,
  lib,
  zlib,
  pkg-config,
  fetchFromGitHub,
}: let
  pname = "spx";
  version = "0.4.15";
in
  buildPecl {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "NoiseByNorthwest";
      repo = "php-spx";
      rev = "v${version}";
      sha256 = "sha256-gw6wbPt1Qy0vNfT0flq7bxpnGU3SgJvPVhk8H0Imvx4=";
      # sha256 = lib.fakeSha256;
    };

    configureFlags = [
      "--with-zlib-dir=${zlib.dev}"
    ];

    postPatch = ''
      sed -i -e 's|spx_ui_assets_dir = .*$|spx_ui_assets_dir = $(out)/web-ui|' Makefile.frag
    '';

    nativeBuildInputs = [pkg-config];
    buildInputs = [zlib];

    meta = with lib; {
      description = "A simple & straight-to-the-point PHP profiling extension with its built-in web UI";
      license = licenses.gpl3;
      homepage = "https://github.com/NoiseByNorthwest/php-spx";
    };
  }
