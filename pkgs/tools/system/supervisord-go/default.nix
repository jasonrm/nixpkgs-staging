{ lib
, buildGoModule
, fetchFromGitHub
, makeWrapper
}:
buildGoModule rec {
  pname = "supervisord-go";
  version = "37a4d835acba81050c5c26446169e567c45ddff9";

  nativeBuildInputs = [ makeWrapper ];

  src = fetchFromGitHub {
    owner = "ochinchina";
    repo = "supervisord";
    rev = version;
    sha256 = "sha256:0841hsp5dg2vf9lx8j5xs1fkrp3i128myh7zk8fvwwfkp893802s";
    # sha256 = lib.fakeSha256;
  };

  subPackages = [ "." ];

  installPhase = ''
    mkdir -p $out/bin $out/share/supervisord
    cp -r ${src}/webgui $out/share/supervisord
    install -m755 $GOPATH/bin/supervisord $out/bin
    wrapProgram $out/bin/supervisord --run "cd $out/share/supervisord"
  '';

  vendorSha256 = "0mwil3qmslqsk390gg8x2ppqjw4a1layzfx50mri6gx6wj7c2y7s";
  # vendorSha256 = lib.fakeSha256;

  meta = with lib; {
    description = "a go-lang supervisor implementation";
    license = licenses.mit;
    homepage = "https://github.com/ochinchina/supervisord";
    maintainer = [ "jason@mcneil.dev" ];
  };
}
