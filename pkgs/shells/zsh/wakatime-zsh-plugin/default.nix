{
  lib,
  stdenv,
  fetchFromGitHub,
  zsh,
}:
stdenv.mkDerivation rec {
  version = "git-69c6028b";
  pname = "wakatime-zsh-plugin";

  src = fetchFromGitHub {
    owner = "sobolevn";
    repo = pname;
    rev = "69c6028b0c8f72e2afcfa5135b1af29afb49764a";
    # hash = lib.fakeHash;
    hash = "sha256-pA1VOkzbHQjmcI2skzB/OP5pXn8CFUz5Ok/GLC6KKXQ=";
  };

  strictDeps = true;

  installPhase = ''
    install -D wakatime.plugin.zsh $out/share/zsh/${pname}/wakatime.plugin.zsh
  '';

  meta = with lib; {
    description = "Track how much time you have spent in your terminal!";
    homepage = "https://github.com/mbenford/zsh-tmux-auto-title";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = ["jason@mcneil.dev"];
  };
}
