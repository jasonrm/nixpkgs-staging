{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "papersmith";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "benletchford";
    repo = pname;
    fetchSubmodules = true;
    rev = "v${version}";
    hash = "sha256-h462e8pP1kl43vnm4t4wY8OGSNeyg95W4G6tkftPvR0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-C8UF4TWajsPup2DOkCdj29sD+Mx8j0crtayhProxoJs=";

  meta = with lib; {
    description = "An AI-powered PDF renamer that uses OpenAI's models to intelligently rename PDF documents based on their content";
    homepage = "https://github.com/benletchford/papersmith";
    license = licenses.mit;
    maintainer = [ "jason@mcneil.dev" ];
    mainProgram = "papersmith";
    platforms = platforms.unix;
  };
}
