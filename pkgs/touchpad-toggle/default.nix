{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  ripgrep,
}:
let
  name = "touchpad-toggle";
in
stdenv.mkDerivation {
  inherit name;

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm755 $src/${name}.fish $out/bin/${name}
  '';

  fixupPhase = ''
    wrapProgram $out/bin/${name} --prefix PATH : ${
      lib.makeBinPath [
        coreutils
        fish
        ripgrep
      ]
    }
  '';

  meta.mainProgram = name;
}
