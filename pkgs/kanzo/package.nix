{
  lib,
  rustPlatform,
  fetchCrate,
  gitMinimal,
  re-plistbuddy,
  stdenv,
}: let
  inherit (lib) licenses optionals;
in
  rustPlatform.buildRustPackage (finalAttrs: {
    pname = "kanzo";
    version = "0.4.2";

    src = fetchCrate {
      inherit (finalAttrs) pname version;
      hash = "sha256-nkNuGGDzm9Z3NeSt6B/1IYy3kqRZ4kjBgglBpndNYvs=";
    };

    cargoHash = "sha256-1M0b4rUc0/jbN5GFtHpldFK/+hLeSiBwywVkHVFh0LI=";
    nativeCheckInputs = [gitMinimal] ++ optionals stdenv.hostPlatform.isDarwin [re-plistbuddy];

    meta = {
      description = "Self-hosted kanban board and MCP server";
      homepage = "https://github.com/emanuele-em/kanzo";
      license = licenses.agpl3Only;
      mainProgram = "kanzo";
    };
  })
