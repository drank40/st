{ pkgs ? import <nixpkgs> {} }:
{
  st-custom = pkgs.st.overrideAttrs (old: {
    pname = "st-custom";
    version = "0-unstable-2026-05-05";
    src = pkgs.fetchFromGitHub {
      owner = "drank40";
      repo = "st";
      rev = "2045474";
      hash = "sha256-/04jlTezS/xgiSQ42T0fd+HcCFxwT8cas1Of0F0BWEc=";
    };

    FONT_SIZE = "28";

    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.git ];
    buildInputs = (old.buildInputs or []) ++ [ pkgs.harfbuzz ];
    buildPhase = ''make'';
    installPhase = ''
      runHook preInstall
      TERMINFO=$out/share/terminfo make clean install PREFIX=$out
      runHook postInstall
    '';
  });
}
