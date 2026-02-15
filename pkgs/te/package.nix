{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "te";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "yusukeshib";
    repo = "te";
    rev = "v${version}";
    hash = "sha256-YlqAszL+mkcugXSXgH4TH3WfthQS5EEjRAaqzfJesbE=";
  };

  cargoHash = "sha256-2lKK+h6yW6VNyU8NACZcT3wRwsjTrEuyq8VzONewWMM=";

  meta = {
    description = "Interactive TUI wrapper for CLI commands";
    homepage = "https://github.com/yusukeshib/te";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
