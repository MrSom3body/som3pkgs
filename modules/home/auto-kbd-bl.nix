{outputs}: {
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib) mkEnableOption;
  cfg = config.services.auto-kbd-bl;
in {
  options.services.auto-kbd-bl = {
    enable = mkEnableOption "the auto keyboard backlight service";
  };

  config = mkIf cfg.enable {
    systemd.user.services.auto-kbd-bl = {
      Unit = {
        Description = "Auto Keyboard Backlight";
      };

      Service = {
        Type = "simple";
        ExecStart = "${outputs.packages.${pkgs.system}.auto-kbd-bl}/bin/auto-kbd-bl";
        Restart = "on-failure";
      };

      Install.WantedBy = ["default.target"];
    };
  };
}
