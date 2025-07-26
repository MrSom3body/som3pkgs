{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  fnott,
  libnotify,
  procps,
  ripgrep,
  systemd,
}: let
  name = "fnott-dnd";
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
          coreutils
          fish
          fnott
          libnotify
          procps
          ripgrep
          systemd
        ]
      }
    '';

    meta.mainProgram = name;
  }
