let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // packages;
  lib = import ./lib.nix;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  # callPackage = path: lib.makeOverridable (callPackage1 path);
  packages = with nixpkgs; {
    mkDerivation = import ./autotools.nix nixpkgs;
    hello = callPackage ./hello.nix { };
    graphviz = lib.makeOverridable(callPackage ./graphviz.nix) { };
    # graphvizcore = callPackage ./graphviz.nix { gdSupport = false; };
    # graphvizcore = graphviz.override { }; 
};
in packages
