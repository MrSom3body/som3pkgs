{outputs}: {
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib) mkEnableOption;
  cfg = config.services.power-monitor;
in {
  options.services.power-monitor = {
    enable = mkEnableOption "the power-monitor service";
  };

  config = mkIf cfg.enable {
    systemd.user.services.power-monitor = {
      Unit = {
        Description = "Power Monitor";
        After = ["power-profiles-daemon.service"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${outputs.packages.${pkgs.system}.power-monitor}/bin/power-monitor";
        Restart = "on-failure";
      };

      Install.WantedBy = ["default.target"];
    };
  };
}
