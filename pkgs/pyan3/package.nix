{
  lib,
  python3Packages,
  fetchFromGitHub,
  ...
}:
python3Packages.buildPythonPackage rec {
  pname = "pyan3";
  version = "2.9.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Technologicat";
    repo = "pyan";
    rev = "v${version}";
    hash = "sha256-3bP29C37W21nI7kIQW2jy0c04wyXZrCNNxdmGNluMNM=";
  };

  build-system = with python3Packages; [
    pdm-backend
  ];

  dependencies = with python3Packages; [
    jinja2
  ];

  # Tests require additional test files and dependencies
  doCheck = false;

  meta = with lib; {
    description = "Offline call graph generator for Python 3";
    longDescription = ''
      Generate approximate call graphs for Python programs.
      Pyan takes one or more Python source files, performs a
      (rather superficial) static analysis, and constructs a directed graph of
      the objects in the combined source, and how they define or
      use each other. The graph can be output for rendering by GraphViz or yEd.
    '';
    homepage = "https://github.com/Technologicat/pyan";
    license = licenses.gpl2Only;
    mainProgram = "pyan3";
  };
}
