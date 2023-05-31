let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // packages;
  lib = import ./lib.nix;
  callPackage1 = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  callPackage = path: lib.makeOverridable (callPackage1 path);
  packages = with nixpkgs; rec {
    mkDerivation = import ./autotools.nix nixpkgs;
    hello = callPackage ./hello.nix { };
    graphviz = callPackage ./graphviz.nix { };
    graphvizcore = graphviz.override { gdSupport = false; }; 
    graphvizcore2 = graphvizcore.override { gdSupport = true; }; 
};
in packages
