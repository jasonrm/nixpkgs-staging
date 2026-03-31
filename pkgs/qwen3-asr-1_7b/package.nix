{
  lib,
  stdenv,
  fetchurl,
  qwen3-asr-rs-bin,
}:
let
  base = "https://huggingface.co/Qwen/Qwen3-ASR-1.7B/resolve/main";
in
stdenv.mkDerivation {
  pname = "qwen3-asr-1_7b";
  version = "0-unstable";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  config_json = fetchurl {
    url = "${base}/config.json";
    hash = "sha256-LnSnUVSLitfXUm0pNlrYFEw0XYtBKxFS0l3GaYRScS8=";
  };

  model_index = fetchurl {
    url = "${base}/model.safetensors.index.json";
    hash = "sha256-+ZRzn+OOUhC54+jObGMHMV4s6sPLYw57dBTWnc5SD2A=";
  };

  model_part1 = fetchurl {
    url = "${base}/model-00001-of-00002.safetensors";
    hash = "sha256-pM0fGgTZC3V9x/fdJiVOaaATsZ6A7+WQqDxqO96GCNY=";
  };

  model_part2 = fetchurl {
    url = "${base}/model-00002-of-00002.safetensors";
    hash = "sha256-bgudngni4COOfvPMikhKs4fpG5DxkAvt+IvJLXkpzPw=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    cp $config_json $out/config.json
    cp $model_index $out/model.safetensors.index.json
    cp $model_part1 $out/model-00001-of-00002.safetensors
    cp $model_part2 $out/model-00002-of-00002.safetensors
    cp ${qwen3-asr-rs-bin}/share/qwen3-asr-rs/tokenizers/tokenizer-1.7B.json $out/tokenizer.json

    runHook postInstall
  '';

  meta = with lib; {
    description = "Qwen3-ASR 1.7B model weights for speech recognition";
    homepage = "https://huggingface.co/Qwen/Qwen3-ASR-1.7B";
    license = licenses.asl20;
    maintainer = [ "jason@mcneil.dev" ];
  };
}
