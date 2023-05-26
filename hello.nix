let 
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in mkDerivation {
  name = "hello-git";
  src = ./hello-2.10.tar.gz;
  buildInputs = [ pkgs.gdb ];
}
