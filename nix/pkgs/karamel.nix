{
  sources ? import ../../npins,
  system ? builtins.currentSystem,
  pkgs ? import sources.nixpkgs { inherit system; config = {}; overlays = []; },
  z3,
  fstar,
}:

let
  version = "21ea5a0a0d277630b4b2dddd9b429dd582d53e66";
  source = pkgs.fetchFromGitHub {
    owner = "FStarLang";
    repo = "karamel";
    rev = version;
    sha256 = "sha256-oZ92WSjlSbFc14iu4saPWrg/yM9i7Et0UuHphuUXDvU=";
  };
in
  pkgs.ocamlPackages.callPackage "${source}/.nix/karamel.nix" {
    inherit version z3 fstar;
  }
