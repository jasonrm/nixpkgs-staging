{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
}:
buildGoModule rec {
  pname = "supervisord-go";
  version = "c2cae38b7454d444f4cb8281d5367d50a55c0011";

  nativeBuildInputs = [makeWrapper];

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = version;
    hash = "sha256-aJ+/hyh6MxYQgnk+cE75TpQbMDYvOHHE6cntF8FflWQ=";
    # hash = lib.fakeHash;
  };

  subPackages = ["."];

  installPhase = ''
    mkdir -p $out/bin $out/share/supervisord
    cp -r ${src}/webgui $out/share/supervisord
    install -m755 $GOPATH/bin/supervisord $out/bin
    wrapProgram $out/bin/supervisord --run "cd $out/share/supervisord"
  '';

  vendorHash = "sha256-Uo2CvjCsWAQlVe5swyabfK4ssKqw4DvZS2w4hsOkFGY=";
  # vendorHash = lib.fakeHash;

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = ["jason@mcneil.dev"];
  };
}
