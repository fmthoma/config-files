self: super: {
    prusa-slicer-alpha = super.prusa-slicer.overrideAttrs (oldAttrs: rec {
        version = "2.5.0-alpha3";
        src = super.fetchFromGitHub {
           owner = "prusa3d";
           repo = "PrusaSlicer";
           sha256 = "00isi82p03f304ir92jvs55yhjwqgv1xnni5sr51pf7fwix9q5qy";
           rev = "version_${version}";
        };
    });
}
