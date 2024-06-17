self: super: {
    super-slicer = super.super-slicer.beta;
    super-slicer_ = super.super-slicer.overrideAttrs (oldAttrs: rec {
        version = "2.5.59.12";
        src = super.fetchFromGitHub {
            owner = "supermerill";
            repo = "SuperSlicer";
            rev = version;
            sha256 = "sha256-UmF3mDOKbe5C3UNhZmes59p3LyCGcX+tlppN0M/YOt0=";
            fetchSubmodules = true;
        };
    });
}
