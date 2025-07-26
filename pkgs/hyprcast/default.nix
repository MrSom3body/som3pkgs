{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  libnotify,
  procps,
  wireplumber,
  wl-screenrec,
}:
let
  name = "hyprcast";
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
        libnotify
        procps
        wireplumber
        wl-screenrec
      ]
    }
  '';

  meta.mainProgram = name;
}
