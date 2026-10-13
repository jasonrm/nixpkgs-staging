{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "mobius";
  version = "0.23.2";

  src = fetchFromGitHub {
    owner = "jhalter";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-YKXy5MZLZdUT57NChuqnRaM53CHHutrrUoD537BVM6E=";
  };

  vendorHash = "sha256-zXJL4BdB0ZhoojGrF9x0ZKZFn3r/f98ZoRuC14GIv08=";

  subPackages = ["cmd/mobius-hotline-server"];

  meta = with lib; {
    description = "A Hotline server implemented in Golang for macOS, Linux, and Windows operating systems";
    license = licenses.mit;
    homepage = "https://github.com/jhalter/mobius";
    maintainer = ["jason@mcneil.dev"];
  };
}
