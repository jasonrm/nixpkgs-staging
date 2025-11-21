{
  lib,
  buildGo125Module,
  fetchFromGitHub,
  nixosTests,
  installShellFiles,
}: let
  generic = {
    buildGoModule,
    version,
    hash,
    vendorHash,
    license,
    ...
  } @ attrs: let
    attrs' = removeAttrs attrs [
      "buildGoModule"
      "version"
      "hash"
      "vendorHash"
      "license"
    ];
  in
    buildGoModule (
      rec {
        pname = "nomad";
        inherit version vendorHash;

        subPackages = ["."];

        src = fetchFromGitHub {
          owner = "hashicorp";
          repo = "nomad";
          rev = "v${version}";
          inherit hash;
        };

        # Nomad requires Go 1.24.6, but nixpkgs doesn't have it in unstable yet.
        postPatch = ''
          substituteInPlace go.mod \
            --replace-warn "go 1.24.6" "go 1.24.5"
        '';

        nativeBuildInputs = [installShellFiles];

        ldflags = [
          "-X github.com/hashicorp/nomad/version.Version=${version}"
          "-X github.com/hashicorp/nomad/version.VersionPrerelease="
          "-X github.com/hashicorp/nomad/version.BuildDate=1970-01-01T00:00:00Z"
        ];

        # ui:
        #  Nomad release commits include the compiled version of the UI, but the file
        #  is only included if we build with the ui tag.
        tags = ["ui"];

        postInstall = ''
          echo "complete -C $out/bin/nomad nomad" > nomad.bash
          installShellCompletion nomad.bash
        '';

        meta = with lib; {
          homepage = "https://developer.hashicorp.com/nomad";
          description = "Distributed, Highly Available, Datacenter-Aware Scheduler";
          mainProgram = "nomad";
          inherit license;
          maintainers = with maintainers; [
            rushmorem
            techknowlogick
            cottand
          ];
        };
      }
      // attrs'
    );
in
  generic {
    buildGoModule = buildGo125Module;
    version = "1.11.0";
    hash = "sha256-ETC9zJVup/BLivsBWVez5/OLpl7cjdlIRACVK9ga3Io=";
    vendorHash = "sha256-WqGWEjaPicpmkARSEQ/bqw8+GSemh1fcM3pb4BGjZpU=";
    license = lib.licenses.bsl11;
    passthru.tests.nomad = nixosTests.nomad;
    preCheck = ''
      export PATH="$PATH:$NIX_BUILD_TOP/go/bin"
    '';
  }
