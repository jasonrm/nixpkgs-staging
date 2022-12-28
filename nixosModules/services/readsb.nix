{
  config,
  pkgs,
  lib,
  ...
}: with lib; let
  cfg = config.services.readsb;
in {
  options = {
    services.readsb = {
      enable = mkEnableOption "Enabled ADS-B decoder swiss knife";
      arguments = mkOption {
        type = types.listOf str;
        default = [
          "--device-type rtlsdr"
          "--net"
          "--net-connector feed1.adsbexchange.com,30004,beast_reduce_out,feed2.adsbexchange.com,64004"
          "--net-heartbeat 60"
          "--net-ro-size 1280"
          "--net-ro-interval 0.2"
          "--net-ro-port 0"
          "--net-sbs-port 0"
          "--net-bi-port 30154"
          "--net-bo-port 0"
          "--net-ri-port 0"
          "--write-json-every 1"
        ];
      };
    };
  };

  config = {
    systemd.services.readsb = mkIf cfg.enable {
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      serviceConfig = {
        ExecStart = "${pkgs.readsb}/bin/readsb ${concatStringsSep " " cfg.arguments}";
        RestartSec = 600;
        Restart = "always";
      };
    };
  };
}
