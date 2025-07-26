{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  inotify-tools,
  libnotify,
  power-profiles-daemon,
}:
let
  name = "power-monitor";
in
stdenv.mkDerivation {
  inherit name;

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm755 $src/${name}.fish $out/bin/${name}
  '';

  fixupPhase = ''
    wrapProgram $out/bin/${name} --set PATH ${
      lib.makeBinPath [
        coreutils
        fish
        inotify-tools
        libnotify
        power-profiles-daemon
      ]
    }
  '';

  meta.mainProgram = name;
}
