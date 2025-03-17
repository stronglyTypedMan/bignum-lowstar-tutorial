{
  sources ? import ../../npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs { inherit system; config = {}; overlays = []; },
  z3,
}:

let
  version = "v2025.02.17";
  source = pkgs.fetchFromGitHub {
    owner = "FStarLang";
    repo = "FStar";
    rev = version;
    sha256 = "sha256-QRZdyaHpVZafdk398yQ4LXmSrcqL/cQeYUBj9dwLDlQ=";
  };
in
  pkgs.ocamlPackages.callPackage "${source}/.nix/fstar.nix" {
    inherit version z3;
  }
