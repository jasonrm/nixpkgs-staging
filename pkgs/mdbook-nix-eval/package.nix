{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "mdbook-nix-eval";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = "mdbook-nix-eval";
    rev = "v${version}";
    hash = "sha256-IRBMMUNTDT0FH8TX9MEM+JRxFSiH0WOnOBGwxBbnu2Y=";
  };

  cargoHash = "sha256-ZIy5y0wf5UyzwpmiFELN6Nu1i1JoBJ5Np7gUTkixWiQ=";

  meta = with lib; {
    description = "A mdbook preprocessor designed to evaluate code blocks containing nix expressions";
    homepage = "https://jasonrm.github.io/mdbook-nix-eval/";
    license = [licenses.mpl20];
    maintainers = ["jason@mcneil.dev"];
  };
}
