{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "cake-stats";
  version = "1.0.26";

  src = fetchFromGitHub {
    owner = "galpt";
    repo = "cake-stats";
    rev = "v${version}";
    hash = "sha256-W/OtC8bkehy6IrQFf0Q3ql26EEodQb4Uw15uUG4jBIY=";
  };

  vendorHash = "sha256-u+xkJr20c+H1ayiT0cITRjZSlnYHfW987Rg7Y0DJwxQ=";

  meta = with lib; {
    description = "Easily monitor CAKE SQM in real-time on OpenWrt or other Linux-based routers";
    license = licenses.mit;
    homepage = "https://github.com/galpt/cake-stats";
    maintainer = ["jason@mcneil.dev"];
  };
}
