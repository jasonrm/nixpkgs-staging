{
  lib,
  fio,
  bc,
  coreutils,
  fetchFromGitHub,
  python3Packages,
  pyan3,
  ...
}:
python3Packages.buildPythonApplication rec {
  pname = "fio-plot";
  version = "1.1.16";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "louwrentius";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-yN0gVm6ZYEIoh91d+0ohJ9yU+VWwYEq3MoG+WgBrs2Q=";
  };

  postPatch = ''
    # Remove the scripts section from setup.py to avoid conflict with entry_points
    substituteInPlace setup.py \
      --replace 'scripts=["bin/fio-plot", "bin/bench-fio"],' ""
  '';

  dependencies = with python3Packages; [
    numpy
    setuptools
    matplotlib
    pillow
    pyparsing
    rich
    pyan3
  ];

  # Make sure runtime dependencies are available in PATH
  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    "${lib.makeBinPath [fio bc coreutils]}"
  ];

  # Tests require specific benchmark data files
  doCheck = false;

  meta = with lib; {
    description = "Create charts from FIO storage benchmark tool output";
    longDescription = ''
      Fio-plot generates charts from FIO storage benchmark data. It can process
      FIO output in JSON format. It can also process FIO log file output (in CSV format).
      It also includes bench-fio, a benchmark tool to automate benchmarking with FIO.
    '';
    homepage = "https://github.com/louwrentius/fio-plot";
    license = licenses.bsd3;
    mainProgram = "fio-plot";
  };
}
