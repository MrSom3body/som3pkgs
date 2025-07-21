{outputs}: {
  auto-kbd-bl = import ./auto-kbd-bl.nix {inherit outputs;};
  power-monitor = import ./power-monitor.nix {inherit outputs;};
}
