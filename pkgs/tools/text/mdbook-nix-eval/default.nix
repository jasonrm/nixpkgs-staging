{ lib, stdenv, fetchFromGitHub, libiconv, rustPlatform, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "mdbook-nix-eval";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = "mdbook-nix-eval";
    rev = "v${version}";
    sha256 = "1rw3i31amy55mzkigdf7j24ymp9w9jmhvnnaqs5rl9hn7qbv4a75";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "0gvpilq5avijba50v4fq0m65glskmz8blgkb8g0jl5rx8bf6y3y6";
  # cargoSha256 = lib.fakeSha256;

  buildInputs = [
    libiconv
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreServices
  ];

  meta = with lib; {
    description = "A mdbook preprocessor designed to evaluate code blocks containing nix expressions";
    homepage = "https://jasonrm.github.io/mdbook-nix-eval/";
    license = [ licenses.mpl20 ];
    # maintainers = [ maintainers.havvy ];
  };
}
