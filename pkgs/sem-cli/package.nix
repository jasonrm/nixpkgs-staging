{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  installShellFiles,
}:
rustPlatform.buildRustPackage rec {
  pname = "sem";
  version = "0.10.1";

  src = fetchFromGitHub {
    owner = "Ataraxy-Labs";
    repo = "sem";
    rev = "v${version}";
    hash = "sha256-ukz4sfgesGZ4nhUpF4vHjUJvEixutlli6KOxTvnUs3s=";
  };

  cargoLock = {
    lockFile = "${src}/crates/Cargo.lock";
  };

  sourceRoot = "source/crates";

  cargoBuildFlags = [
    "--package"
    "sem-cli"
  ];

  # Tests require a git repository and are integration-heavy
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    installShellFiles
  ];

  postInstall = ''
    installShellCompletion --cmd sem \
      --bash <($out/bin/sem completions bash) \
      --zsh <($out/bin/sem completions zsh) \
      --fish <($out/bin/sem completions fish)
  '';

  buildInputs = [
    openssl
  ];

  meta = with lib; {
    description = "Semantic version control CLI. Shows what entities changed (functions, classes, methods) instead of lines.";
    homepage = "https://github.com/Ataraxy-Labs/sem";
    license = with licenses; [mit asl20];
    mainProgram = "sem";
    maintainer = ["jason@mcneil.dev"];
    platforms = platforms.unix;
  };
}
