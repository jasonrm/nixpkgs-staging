{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "cgroup-exporter";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "arianvp";
    repo = "cgroup-exporter";
    rev = "v${version}";
    hash = "sha256-lv9Ox8SLAbru9CEIQLB9DahUq3iMPO+rtzy08Y3365s=";
    # hash = lib.fakeHash;
  };

  vendorHash = "sha256-PzUdwc04criIThlCDoQKR9N3xBkRSc3UpEGwyBHIlYI=";
  # vendorHash = lib.fakeHash;

  env.CGO_ENABLED = 0;

  meta = with lib; {
    description = "A lightweight Prometheus exporter for cgroups v2";
    license = licenses.asl20;
    homepage = "https://github.com/arianvp/cgroup-exporter";
    mainProgram = "cgroup-exporter";
    maintainer = ["jason@mcneil.dev"];
  };
}
