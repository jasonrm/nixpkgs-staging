{
  lib,
  stdenv,
  python3Packages,
  fetchPypi,
  ymodem,
  ...
}:
python3Packages.buildPythonApplication rec {
  pname = "ltchiptool";
  version = "4.14.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-neOqX6ZZ6f92RiBy68fsVwUVNJpuobCL7Agu1v7rK1I=";
  };

  build-system = with python3Packages; [
    poetry-core
  ];

  dependencies = with python3Packages;
    [
      bitstruct
      bk7231tools
      click
      colorama
      hexdump
      importlib-metadata
      prettytable
      py-datastruct
      requests
      semantic-version
      xmodem
      ymodem
    ]
    ++ lib.optionals (stdenv.hostPlatform.isAarch32 || stdenv.hostPlatform.isAarch64) [pyaes]
    ++ lib.optionals (!(stdenv.hostPlatform.isAarch32 || stdenv.hostPlatform.isAarch64)) [pycryptodome];

  pythonImportsCheck = ["ltchiptool"];

  installCheckPhase = ''
    $out/bin/ltchiptool list boards > /dev/null
  '';

  meta = with lib; {
    description = "CLI flashing and binary manipulation tool for IoT chips";
    homepage = "https://github.com/libretiny-eu/ltchiptool";
    license = licenses.mit;
    mainProgram = "ltchiptool";
  };
}
