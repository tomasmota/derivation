let
  nixpkgs = import <nixpkgs> {};
  allPkgs = nixpkgs // packages;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  packages = with nixpkgs; {
    mkDerivation = import ./autotools.nix nixpkgs;
    hello = callPackage ./hello.nix { };
    graphviz = callPackage ./graphviz.nix { };
    graphvizcore = callPackage ./graphviz.nix { gdSupport = false; };
};
in packages
