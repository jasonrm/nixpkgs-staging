{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "cake-stats";
  version = "1.0.30";

  src = fetchFromGitHub {
    owner = "galpt";
    repo = "cake-stats";
    rev = "v${version}";
    hash = "sha256-958WMfpOlXTpUg9zoI8+u9iZA9dBpg3JrpA7frdXgCs=";
  };

  vendorHash = "sha256-u+xkJr20c+H1ayiT0cITRjZSlnYHfW987Rg7Y0DJwxQ=";

  meta = with lib; {
    description = "Easily monitor CAKE SQM in real-time on OpenWrt or other Linux-based routers";
    license = licenses.mit;
    homepage = "https://github.com/galpt/cake-stats";
    maintainer = ["jason@mcneil.dev"];
  };
}
