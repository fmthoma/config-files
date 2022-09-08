self: super: {
    super-slicer_ = super.super-slicer.overrideAttrs (oldAttrs: rec {
        version = "2.5.59.0";
        src = super.fetchFromGitHub {
            owner = "supermerill";
            repo = "SuperSlicer";
            rev = version;
            sha256 = "0ar2jwdvmrhhwxgykdw6v1dgyzd81rarw2rwwml0sr272if73344";
            fetchSubmodules = true;
        };
    });

    super-slicer = let
        prusa-slicer' = super.prusa-slicer.override { wxGTK31-gtk3-override = super.wxGTK31-gtk3; };
    in
    prusa-slicer'.overrideAttrs (oldAttrs: rec {
        pname = "super-slicer";
        version = "2.5.59.0";

        src = self.fetchFromGitHub {
            owner = "supermerill";
            repo = "SuperSlicer";
            sha256 = "0ar2jwdvmrhhwxgykdw6v1dgyzd81rarw2rwwml0sr272if73344";
            rev = version;
            fetchSubmodules = true;
        };

        patches = [
            # Fix detection of TBB, see https://github.com/prusa3d/PrusaSlicer/issues/6355
            (self.fetchpatch {
                url = "https://github.com/prusa3d/PrusaSlicer/commit/76f4d6fa98bda633694b30a6e16d58665a634680.patch";
                sha256 = "1r806ycp704ckwzgrw1940hh1l6fpz0k1ww3p37jdk6mygv53nv6";
            })
            # Fix compile error with boost 1.79. See https://github.com/supermerill/SuperSlicer/issues/2823
            (self.fetchpatch {
                url = "https://raw.githubusercontent.com/gentoo/gentoo/81e3ca3b7c131e8345aede89e3bbcd700e1ad567/media-gfx/superslicer/files/superslicer-2.4.58.3-boost-1.79-port-v2.patch";
                sha256 = "sha256-xMbUjumPZ/7ulyRuBA76CwIv4BOpd+yKXCINSf58FxI=";
            })
        ];

        # We don't need PS overrides anymore, and gcode-viewer is embedded in the binary.
        postInstall = null;
        separateDebugInfo = true;

        # See https://github.com/supermerill/SuperSlicer/issues/432
        cmakeFlags = oldAttrs.cmakeFlags ++ [
            "-DSLIC3R_BUILD_TESTS=0"
        ];

        desktopItems = [
            (self.makeDesktopItem {
                name = "superslicer";
                exec = "superslicer";
                icon = "SuperSlicer";
                comment = "PrusaSlicer fork with more features and faster development cycle";
                desktopName = "SuperSlicer";
                genericName = "3D printer tool";
                categories = [ "Development" ];
            })
        ];
    });
}
