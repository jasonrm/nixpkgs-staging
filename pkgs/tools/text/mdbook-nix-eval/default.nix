{ lib, stdenv, fetchFromGitHub, libiconv, rustPlatform, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "mdbook-nix-eval";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "jasonrm";
    repo = "mdbook-nix-eval";
    rev = "v${version}";
    sha256 = "0pzzf7jyq378nc27ffdzka676a0jblp259cjqsqcy27z5hzcvnhn";
    # sha256 = lib.fakeSha256;
  };

  cargoSha256 = "16llg6pcx3lq8szyl2adq0mibvdvdlavz2kv0cs7rzcmdsq356fn";
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
