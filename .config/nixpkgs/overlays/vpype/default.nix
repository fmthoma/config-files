self: super: {
    pnoise = with self; with self.python3Packages; callPackage ./pnoise.nix {};
    svgelements = with self; with self.python3Packages; callPackage ./svgelements.nix {};
    vpype = with self; with self.python3Packages; callPackage ./vpype.nix {};
}
