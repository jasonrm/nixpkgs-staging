{ lib, stdenv, fetchFromGitHub, zsh }:

stdenv.mkDerivation rec {
  version = "git-07fd6d78";
  pname = "zsh-tmux-auto-title";

  src = fetchFromGitHub {
    owner = "mbenford";
    repo = pname;
    rev = "07fd6d7864df9aed4fbc5e1f67e1ad6eeef0a01f";
    # hash = lib.fakeHash;
    hash = "sha256-4L1HATgGPJ6t7jZbyU8AHjEO9Xao7+WrqIb/RWNpmWQ=";
  };

  strictDeps = true;

  installPhase = ''
    install -D zsh-tmux-auto-title.plugin.zsh $out/share/zsh/${pname}/zsh-tmux-auto-title.plugin.zsh
  '';

  meta = with lib; {
    description = "ZSH plugin for tmux that automatically sets the title of windows/panes as the current foreground command";
    homepage = "https://github.com/mbenford/zsh-tmux-auto-title";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [ "jason@mcneil.dev" ];
  };
}
