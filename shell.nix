let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { config = {}; overlays = []; };
  z3 = pkgs.callPackage ./nix/pkgs/fstar-z3.nix {};
  fstar = pkgs.callPackage ./nix/pkgs/fstar.nix {
    inherit z3;
  };
  karamel = pkgs.callPackage ./nix/pkgs/karamel.nix {
    inherit z3 fstar;
  };
  customPackages = [ z3 fstar karamel ];
  vanillaPackages = with pkgs; [ gnumake ocamlPackages.findlib ];
in

pkgs.mkShell {
  packages = customPackages ++ vanillaPackages;

  #inputsFrom = [ ];

  shellHook = ''
    export KRML_HOME=${karamel.home}
    export FSTAR_EXE=${fstar}/bin/fstar.exe
  '';
}
