{
  lib,
  rustPlatform,
  fetchFromGitHub,
  gitMinimal,
  re-plistbuddy,
  stdenv,
}: let
  inherit (lib) licenses optionals;
in
  rustPlatform.buildRustPackage (finalAttrs: {
    pname = "kanzo";
    version = "0.4.2-unstable-2026-11-25";

    src = fetchFromGitHub {
      owner = "bitnixdev";
      repo = finalAttrs.pname;
      rev = "89326650426879b3b5113ee1c03cf1c9266cc61d";
      hash = "sha256-BT7bGZ0nTv/Aw2HRafO57g+IRTMnOoikawXXg9vR+Pc=";
    };

    cargoHash = "sha256-yLoqEKu1Dudks7acUl4xzegDsbX62Def6pMSEe7DFVw=";
    nativeCheckInputs = [gitMinimal] ++ optionals stdenv.hostPlatform.isDarwin [re-plistbuddy];

    meta = {
      description = "Self-hosted kanban board and MCP server";
      homepage = "https://github.com/bitnixdev/kanzo";
      license = licenses.agpl3Only;
      mainProgram = "kanzo";
    };
  })
