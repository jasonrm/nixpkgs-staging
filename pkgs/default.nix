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
          excimer = pkgs.callPackage ./development/php-packages/excimer {inherit (prev) buildPecl;};
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
  radio_tool = pkgs.callPackage ./applications/radio/radio_tool {};
  readsb = pkgs.callPackage ./applications/radio/readsb {};
  glscopeclient = pkgs.callPackage ./applications/science/electronics/glscopeclient {
    inherit ffts;
  };

  frep = pkgs.callPackage ./development/tools/frep {};
  migrant = pkgs.callPackage ./development/tools/migrant {};
  names = pkgs.callPackage ./development/tools/names {};
  git-clean = pkgs.callPackage ./development/tools/git-clean {};
  cargo-vcpkg = pkgs.callPackage ./development/tools/cargo-vcpkg {};
  defmt = pkgs.callPackage ./development/tools/defmt {};

  # TODO: Is there a better alternative to this?
  php = pkgs.php.override phpExtensions;
  php82 = pkgs.php82.override phpExtensions;
  php83 = pkgs.php83.override phpExtensions;

  redis-cell = pkgs.callPackage ./development/libraries/redis-cell {};
  ffts = pkgs.callPackage ./development/libraries/ffts {};

  zsh-tmux-auto-title = pkgs.callPackage ./shells/zsh/zsh-tmux-auto-title {};
  wakatime-zsh-plugin = pkgs.callPackage ./shells/zsh/wakatime-zsh-plugin {};

  imaptar = pkgs.callPackage ./tools/backup/imaptar {};
  imapbox = pkgs.callPackage ./tools/backup/imapbox {};
  up = pkgs.callPackage ./tools/backup/up {};

  manticoresearch = pkgs.callPackage ./servers/search/manticoresearch {};
  imageproxy = pkgs.callPackage ./servers/imageproxy {};
  slowlogfmt = pkgs.callPackage ./servers/monitoring/slowlogfmt {};
  etherdfs = pkgs.callPackage ./servers/etherdfs {};
  radius-mac = pkgs.callPackage ./servers/radius-mac {};
  dynamodb = pkgs.callPackage ./servers/dynamodb {};

  go-httpbin = pkgs.callPackage ./tools/networking/go-httpbin {};

  vsd = pkgs.callPackage ./tools/misc/vsd {};

  arcanum = pkgs.callPackage ./tools/system/arcanum {};
  github-auth3 = pkgs.callPackage ./tools/system/github-auth3 {};
  pushnix = pkgs.callPackage ./tools/system/pushnix {};
  ssh-permit-a38 = pkgs.callPackage ./tools/system/ssh-permit-a38 {};
  supervisord-go = pkgs.callPackage ./tools/system/supervisord-go {};
  uritool = pkgs.callPackage ./tools/system/uritool {};
  intelmas = pkgs.callPackage ./tools/system/intelmas {};
  rnd64 = pkgs.callPackage ./tools/system/rnd64 {};
  machma = pkgs.callPackage ./tools/system/machma {};
  vlmcsd = pkgs.callPackage ./tools/system/vlmcsd {};
  systemd-tmpfiles = pkgs.callPackage ./tools/system/systemd-tmpfiles {};

  mdbook-nix-eval = pkgs.callPackage ./tools/text/mdbook-nix-eval {};

  yubikey-agent = pkgs.callPackage "${pkgs.path}/pkgs/by-name/yu/yubikey-agent/package.nix" {
    buildGoModule = args:
      pkgs.buildGoModule (args
        // {
          src = pkgs.fetchFromGitHub {
            owner = "jasonrm";
            repo = "yubikey-agent";
            rev = "9a64bd0ca5b05b8a685a0f83e2a7d0a01f7489dd";
            # hash = lib.fakeHash;
            hash = "sha256-Wbm569DqVf7q8zg3lvWdgGaS6IFS9FSxfvD98zc/I14=";
          };

          vendorHash = "sha256-ZQCxW+NDeYJofC9/9z8BpcRtBJ5p7hfQfsaX7iRIw5w=";
          # vendorHash = lib.fakeHash;
        });
  };
}
