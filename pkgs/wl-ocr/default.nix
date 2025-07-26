# copied from @fufexan
{
  lib,
  stdenv,
  makeWrapper,
  fish,
  grim,
  libnotify,
  slurp,
  tesseract,
  wl-clipboard,
}: let
  name = "wl-ocr";
in
  stdenv.mkDerivation {
    inherit name;

    src = ./.;

    nativeBuildInputs = [makeWrapper];

    installPhase = ''
      install -Dm755 $src/${name}.fish $out/bin/${name}
    '';

    fixupPhase = ''
      wrapProgram $out/bin/${name} --set PATH ${
        lib.makeBinPath [
          fish
          grim
          libnotify
          slurp
          tesseract
          wl-clipboard
        ]
      }
    '';

    meta.mainProgram = name;
  }
