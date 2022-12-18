self: super: {
    vpype = with self; with self.python3Packages; let
        pnoise = callPackage ./pnoise.nix {};
        svgelements = callPackage ./svgelements.nix {};
        hatched = callPackage ./hatched.nix {};
        deduplicate = callPackage ./deduplicate.nix {};
    in callPackage ./vpype.nix { inherit pnoise svgelements hatched deduplicate; };
}
