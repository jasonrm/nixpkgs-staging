{
  lib,
  stdenv,
  fetchurl,
  qwen3-asr-rs-bin,
}:
let
  base = "https://huggingface.co/Qwen/Qwen3-ASR-0.6B/resolve/main";
in
stdenv.mkDerivation {
  pname = "qwen3-asr-0_6b";
  version = "0-unstable";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  config_json = fetchurl {
    url = "${base}/config.json";
    hash = "sha256-dtOuRgHOk5gwslF/SmytuGzFExbDkAr2sCCwUcIaR4w=";
  };

  model = fetchurl {
    url = "${base}/model.safetensors";
    hash = "sha256-edbL1MmMe7/+nbLtrAf1bNZjfQ1ZRLJ/bCuDU4QDI+o=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    cp $config_json $out/config.json
    cp $model $out/model.safetensors
    cp ${qwen3-asr-rs-bin}/share/qwen3-asr-rs/tokenizers/tokenizer-0.6B.json $out/tokenizer.json

    runHook postInstall
  '';

  meta = with lib; {
    description = "Qwen3-ASR 0.6B model weights for speech recognition";
    homepage = "https://huggingface.co/Qwen/Qwen3-ASR-0.6B";
    license = licenses.asl20;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
