{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
}:
buildGoModule rec {
  pname = "supervisord-go";
  version = "b1093f8906480aac2a7c82c8fa94e1e518fd6a62";

  nativeBuildInputs = [makeWrapper];

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = version;
    hash = "sha256-MVxNi7r4n6Dsopz9FRFOpLpJbg+yfDoOePzHH4r1vv4=";
    # hash = lib.fakeSha256;
  };

  subPackages = ["."];

  installPhase = ''
    mkdir -p $out/bin $out/share/supervisord
    cp -r ${src}/webgui $out/share/supervisord
    install -m755 $GOPATH/bin/supervisord $out/bin
    wrapProgram $out/bin/supervisord --run "cd $out/share/supervisord"
  '';

  vendorSha256 = "sha256-HHsCzSCC2fTbPR0Y/NpRnUKoH2DXu5J98aVIYw3Qw04=";
  # vendorSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = ["jason@mcneil.dev"];
  };
}
