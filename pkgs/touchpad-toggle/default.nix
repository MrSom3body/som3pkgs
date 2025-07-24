{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  ripgrep,
}:
stdenv.mkDerivation rec {
  name = "touchpad-toggle";

  src = ./.;

  nativeBuildInputs = [makeWrapper];

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
