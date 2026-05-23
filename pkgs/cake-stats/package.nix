{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "cake-stats";
  version = "1.0.29";

  src = fetchFromGitHub {
    owner = "galpt";
    repo = "cake-stats";
    rev = "v${version}";
    hash = "sha256-v5Dtc2C5r/m6zMq0aOh/okNHMectIGiO7i6cBGkMfc8=";
  };

  vendorHash = "sha256-u+xkJr20c+H1ayiT0cITRjZSlnYHfW987Rg7Y0DJwxQ=";

  meta = with lib; {
    description = "Easily monitor CAKE SQM in real-time on OpenWrt or other Linux-based routers";
    license = licenses.mit;
    homepage = "https://github.com/galpt/cake-stats";
    maintainer = ["jason@mcneil.dev"];
  };
}
