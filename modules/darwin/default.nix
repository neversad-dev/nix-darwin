{mylib, ...}: {
  imports =
    (mylib.scanPaths ./.)
    ++ [
      ../common/packages.nix
    ];
}