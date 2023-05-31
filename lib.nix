rec {
  makeOverridable = f : origArgs :
    let
      origRes = f origArgs;
    in
      origRes // { override = newArgs : makeOverridable f (origArgs // newArgs); add2 = x: x + 2; };
}
