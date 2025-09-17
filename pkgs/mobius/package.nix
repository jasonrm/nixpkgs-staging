{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "mobius";
  version = "0.18.4";

  src = fetchFromGitHub {
    owner = "jhalter";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-M5MuRSSRjT6gMe3Re8vpmQE/SONdhdH/zbtlN6C6G6Y=";
  };

  vendorHash = "sha256-ohN1iWdjrXc4ShyRMxuQAMtDjVyl9rUigJ1Hr/Qbf4s=";

  subPackages = ["cmd/mobius-hotline-server"];

  meta = with lib; {
    description = "A Hotline server implemented in Golang for macOS, Linux, and Windows operating systems";
    license = licenses.mit;
    homepage = "https://github.com/jhalter/mobius";
    maintainer = ["jason@mcneil.dev"];
  };
}
