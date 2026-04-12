{
  lib,
  stdenv,
  gpsd,
  python3,
  fetchFromGitHub,
  makeWrapper,
  ...
}:
let
  pythonEnv = python3.withPackages (ps: [
    ps.prometheus-client
  ]);
in
stdenv.mkDerivation rec {
  pname = "gpsd-prometheus-exporter";
  version = "1.1.19";

  src = fetchFromGitHub {
    owner = "brendanbank";
    repo = "gpsd-prometheus-exporter";
    rev = "v${version}";
    hash = "sha256-87j9DpMk8T7HfeHMCZDqjVBBqydIHqE01e7+bd+6bhA=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 gpsd_exporter.py $out/bin/gpsd-prometheus-exporter
    wrapProgram $out/bin/gpsd-prometheus-exporter \
      --set PYTHONPATH "${pythonEnv}/${pythonEnv.sitePackages}:${gpsd}/${python3.sitePackages}" \
      --set PATH "${pythonEnv}/bin"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Prometheus exporter for gpsd GPS daemon metrics";
    homepage = "https://github.com/brendanbank/gpsd-prometheus-exporter";
    license = licenses.bsd3;
    mainProgram = "gpsd-prometheus-exporter";
  };
}
