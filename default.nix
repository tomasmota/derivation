let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // packages;
  lib = import ./lib.nix;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  # callPackage = path: lib.makeOverridable (callPackageBase path);
  packages = with nixpkgs; {
    mkDerivation = import ./autotools.nix nixpkgs;
    hello = callPackage ./hello.nix { };
    graphviz = callPackage ./graphviz.nix { };
    graphvizcore = callPackage ./graphviz.nix { gdSupport = false; };
    # graphvizcore = graphviz.override { gdSupport = false; }; 
};
in packages
