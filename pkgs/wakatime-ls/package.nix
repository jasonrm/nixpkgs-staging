{
  lib,
  fetchFromGitHub,
  rustPlatform,
  wakatime-cli,
  makeWrapper,
}:
rustPlatform.buildRustPackage rec {
  pname = "wakatime-ls";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "mrnossiom";
    repo = "wakatime-ls";
    rev = "v${version}";
    hash = "sha256-r0XvD9ZTnyEE1W95iOBHeXshxce1MSdq1OYFJ8pCsTU=";
  };

  cargoHash = "sha256-KLQDu7mQgxq4HxrJ4cX9WEdDlmuakPYZOdTzL9Ot4Wg=";

  nativeBuildInputs = [
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/wakatime-ls \
      --prefix PATH : ${lib.makeBinPath [wakatime-cli]}
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/wakatime-ls --health
  '';

  meta = with lib; {
    description = "A dead-simple language server around wakatime-cli to send code tracking heartbeats";
    homepage = "https://github.com/mrnossiom/wakatime-ls";
    license = licenses.cecill21;
  };
}
