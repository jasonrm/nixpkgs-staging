{
  lib,
  stdenv,
  fetchzip,
  autoPatchelfHook,
  makeWrapper,
}:
let
  version = "0.2.0";

  assets = {
    "aarch64-darwin" = {
      asset = "asr-macos-aarch64";
      hash = "sha256-hDxUlPvklSazkmQUDCcvQcZ+VO7Zy+N1vfc9n7ng718=";
    };
    "x86_64-linux" = {
      asset = "asr-linux-x86_64";
      hash = "sha256-zp427J30tPqwNel98AwFc0gijdmjEH+jrzXlcwW2FrI=";
    };
    "aarch64-linux" = {
      asset = "asr-linux-aarch64";
      hash = "sha256-FIXME";
    };
  };

  platform = assets.${stdenv.hostPlatform.system} or (throw "Unsupported platform: ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "qwen3-asr-rs-bin";
  inherit version;

  src = fetchzip {
    url = "https://github.com/second-state/qwen3_asr_rs/releases/download/v${version}/${platform.asset}.zip";
    hash = platform.hash;
    stripRoot = true;
  };

  nativeBuildInputs =
    lib.optionals stdenv.isLinux [ autoPatchelfHook ]
    ++ [ makeWrapper ];

  buildInputs = lib.optionals stdenv.isLinux [
    stdenv.cc.cc.lib
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/qwen3-asr-rs/tokenizers

    cp asr $out/bin/
    cp asr-server $out/bin/

    cp tokenizers/*.json $out/share/qwen3-asr-rs/tokenizers/

    ${lib.optionalString stdenv.isDarwin ''
      cp mlx.metallib $out/bin/
    ''}

    ${lib.optionalString stdenv.isLinux ''
      mkdir -p $out/lib
      cp -r libtorch/lib/*.so* $out/lib/

      wrapProgram $out/bin/asr \
        --prefix LD_LIBRARY_PATH : $out/lib
      wrapProgram $out/bin/asr-server \
        --prefix LD_LIBRARY_PATH : $out/lib
    ''}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Rust CLI and API server for Qwen3-ASR speech recognition";
    homepage = "https://github.com/second-state/qwen3_asr_rs";
    license = licenses.asl20;
    maintainer = [ "jason@mcneil.dev" ];
    platforms = builtins.attrNames assets;
  };
}
