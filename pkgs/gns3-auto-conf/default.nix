{
  lib,
  stdenv,
  makeWrapper,
  coreutils,
  fish,
  fzf,
  jq,
}:
let
  name = "gns3-auto-conf";
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
        fzf
        jq
      ]
    }
  '';

  meta.mainProgram = name;
}
