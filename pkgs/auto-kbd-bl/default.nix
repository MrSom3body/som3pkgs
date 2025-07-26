{
  lib,
  stdenv,
  makeWrapper,
  brightnessctl,
  coreutils,
  fish,
  inotify-tools,
}:
let
  name = "auto-kbd-bl";
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
        brightnessctl
        coreutils
        fish
        inotify-tools
      ]
    }
  '';

  meta.mainProgram = name;
}
