{ pkgs, stdenv, fetchFromGitHub, z3_4_8_5, z3 }:

let
  z3_4_13_3 = z3.overrideAttrs (old: rec {
    version = "4.13.3";
    src = fetchFromGitHub {
        owner = "z3prover";
        repo = "z3";
        rev = "z3-${version}";
        sha256 = "sha256-odwalnF00SI+sJGHdIIv4KapFcfVVKiQ22HFhXYtSvA=";
    };
  });
in
stdenv.mkDerivation {
  pname = "fstar-z3";
  version = "1";

  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out/bin
    ln -s ${z3_4_8_5}/bin/z3 $out/bin/z3-4.8.5
    ln -s ${z3_4_13_3}/bin/z3 $out/bin/z3-4.13.3
  '';
}