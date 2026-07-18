{
  lib,
  python3Packages,
  fetchPypi,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "ymodem";
  version = "1.5.3";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-LlNijZ9Tirysk7yf+3KRnfdGewJmRvdV2M8FxdVSKJ0=";
  };

  build-system = with python3Packages; [
    setuptools
    setuptools-scm
  ];

  dependencies = with python3Packages; [
    ordered-set
    pyserial
  ];

  pythonImportsCheck = ["ymodem"];

  meta = with lib; {
    description = "YMODEM protocol implementation for Python";
    homepage = "https://github.com/alexwoo1900/ymodem";
    license = licenses.mit;
    mainProgram = "ymodem";
  };
}
