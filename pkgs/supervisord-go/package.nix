{
  lib,
  buildGo127Module,
  fetchFromGitHub,
  makeWrapper,
}:
buildGo127Module rec {
  pname = "supervisord-go";
  version = "0.7.6";

  nativeBuildInputs = [makeWrapper];

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = "v${version}";
    hash = "sha256-l0cbkrX5Mj92IZCEeirySrvyUOvRWNJaC4W0EYBqWP0=";
  };

  # Build the root module; its go.mod already replaces the local XML-RPC module.
  env.GOWORK = "off";
  subPackages = ["."];

  installPhase = ''
    mkdir -p $out/bin $out/share/supervisord
    cp -r ${src}/webgui $out/share/supervisord
    install -m755 $GOPATH/bin/supervisord $out/bin
    wrapProgram $out/bin/supervisord --run "cd $out/share/supervisord"
  '';

  vendorHash = "sha256-THsTIXFYZR7Gtr2nT/tZZqbxJgylMme1Ik+9hHGskIc=";

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = ["jason@mcneil.dev"];
  };
}
