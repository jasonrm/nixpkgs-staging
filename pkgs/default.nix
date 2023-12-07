{
  pkgs,
  lib,
  ...
}: let
  phpExtensions = {
    packageOverrides = final: prev: {
      extensions =
        prev.extensions
        // {
          spx = pkgs.callPackage ./development/php-packages/spx {inherit (prev) buildPecl;};
        };
    };
  };
  # libOverlay = lib // (import ./lib { inherit pkgs lib; });
in rec {
  customLib = pkgs.callPackage ./lib {};

  nodePackages = pkgs.nodePackages.extend (final: prev: (pkgs.callPackage ./development/node-packages {}));

  nomad-driver-nix = pkgs.callPackage ./applications/networking/cluster/nomad-driver-nix {};
  lossless-cut = pkgs.callPackage ./applications/video/lossless-cut {};
  ddns = pkgs.callPackage ./applications/networking/dyndns/ddns {};
  transmission-rss-go = pkgs.callPackage ./applications/networking/p2p/transmission-rss-go {};
  trunk-recorder = pkgs.callPackage ./applications/radio/trunk-recorder {};
  readsb = pkgs.callPackage ./applications/radio/readsb {};
  glscopeclient = pkgs.callPackage ./applications/science/electronics/glscopeclient {
    inherit ffts;
  };

  frep = pkgs.callPackage ./development/tools/frep {};
  migrant = pkgs.callPackage ./development/tools/migrant {};
  names = pkgs.callPackage ./development/tools/names {};
  git-clean = pkgs.callPackage ./development/tools/git-clean {};

  # TODO: Is there a better alternative to this?
  php = pkgs.php.override phpExtensions;
  php80 = pkgs.php80.override phpExtensions;
  php81 = pkgs.php81.override phpExtensions;
  php82 = pkgs.php82.override phpExtensions;

  redis-cell = pkgs.callPackage ./development/libraries/redis-cell {};
  ffts = pkgs.callPackage ./development/libraries/ffts {};

  zsh-tmux-auto-title = pkgs.callPackage ./shells/zsh/zsh-tmux-auto-title {};
  wakatime-zsh-plugin = pkgs.callPackage ./shells/zsh/wakatime-zsh-plugin {};

  bupstash = pkgs.callPackage ./tools/backup/bupstash {};
  imaptar = pkgs.callPackage ./tools/backup/imaptar {};
  imapbox = pkgs.callPackage ./tools/backup/imapbox {};
  up = pkgs.callPackage ./tools/backup/up {};

  manticoresearch = pkgs.callPackage ./servers/search/manticoresearch {};
  imageproxy = pkgs.callPackage ./servers/imageproxy {};
  slowlogfmt = pkgs.callPackage ./servers/monitoring/slowlogfmt {};
  etherdfs = pkgs.callPackage ./servers/etherdfs {};
  radius-mac = pkgs.callPackage ./servers/radius-mac {};

  silverbullet = pkgs.callPackage ./servers/web-apps/silverbullet {};

  go-httpbin = pkgs.callPackage ./tools/networking/go-httpbin {};

  github-auth3 = pkgs.callPackage ./tools/system/github-auth3 {};
  pushnix = pkgs.callPackage ./tools/system/pushnix {};
  ssh-permit-a38 = pkgs.callPackage ./tools/system/ssh-permit-a38 {};
  supervisord-go = pkgs.callPackage ./tools/system/supervisord-go {};
  uritool = pkgs.callPackage ./tools/system/uritool {};
  intelmas = pkgs.callPackage ./tools/system/intelmas {};
  rnd64 = pkgs.callPackage ./tools/system/rnd64 {};
  machma = pkgs.callPackage ./tools/system/machma {};
  vlmcsd = pkgs.callPackage ./tools/system/vlmcsd {};
  tere = pkgs.callPackage ./tools/system/tere {};
  hashname = pkgs.callPackage ./tools/system/hashname {};
  systemd-tmpfiles = pkgs.callPackage ./tools/system/systemd-tmpfiles {};

  mdbook-nix-eval = pkgs.callPackage ./tools/text/mdbook-nix-eval {};

  yubikey-agent = pkgs.callPackage "${pkgs.path}/pkgs/tools/security/yubikey-agent" {
    buildGoModule = args:
      pkgs.buildGoModule (args
        // {
          src = pkgs.fetchFromGitHub {
            owner = "jasonrm";
            repo = "yubikey-agent";
            rev = "3eb039f4678752272ade0ea6de3cc218dc25f2a0";
            # hash = lib.fakeHash;
            hash = "sha256-4Y8aMZHnclWWSO7tu2BBIC9hhi4gd9hou+Bvf4nnbPE=";
          };

          vendorHash = "sha256-+IRPs3wm3EvIgfQRpzcVpo2JBaFQlyY/RI1G7XfVS84=";
          # vendorHash = lib.fakeHash;
        });
  };
}
