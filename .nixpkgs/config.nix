{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; rec {
    inherit pkgs;

    premake5 = callPackage ./pkgs/premake5/default.nix {};

    otfcc = callPackage ./pkgs/otfcc/default.nix {};

    iosevka = callPackage ./pkgs/iosevka/default.nix {};

    imposevka = callPackage ./pkgs/iosevka/imposevka.nix {};
  };
}
