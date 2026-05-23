{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "mobius";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "jhalter";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Bm5GKqJsXuodZ2up9kz8ixlY/Iz/Z3OAy6WfbGhQ2ww=";
  };

  vendorHash = "sha256-/TaKTvkNi67iASTApxWfIy9C8SnNl6boVoQT8YE3SFg=";

  subPackages = ["cmd/mobius-hotline-server"];

  meta = with lib; {
    description = "A Hotline server implemented in Golang for macOS, Linux, and Windows operating systems";
    license = licenses.mit;
    homepage = "https://github.com/jhalter/mobius";
    maintainer = ["jason@mcneil.dev"];
  };
}
