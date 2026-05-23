{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
}:
buildGoModule rec {
  pname = "supervisord-go";
  version = "16cb640325b3a4962b2ba17d68fb5c2b1e1b6b3c";

  nativeBuildInputs = [makeWrapper];

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = version;
    hash = "sha256-NPlU2f+zXw1qHWKTyTghQmulDuphpLZ3K/Pr/K9J7KI=";
  };

  subPackages = ["."];

  installPhase = ''
    mkdir -p $out/bin $out/share/supervisord
    cp -r ${src}/webgui $out/share/supervisord
    install -m755 $GOPATH/bin/supervisord $out/bin
    wrapProgram $out/bin/supervisord --run "cd $out/share/supervisord"
  '';

  vendorHash = "sha256-W/68Kq5Z9+7fUKQGq1/hI12pLznlKRYw7x464ZJVxtM=";

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = ["jason@mcneil.dev"];
  };
}
