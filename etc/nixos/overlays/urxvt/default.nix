self: super: {
  rxvt_unicode = super.rxvt_unicode.overrideAttrs (oldAttrs : {
    patches = [
      (super.fetchpatch {
        url = "https://gist.githubusercontent.com/fmthoma/7e8dd23c12b55cae6474/raw/78378cf5e175d0d07f645d7ba0dd437e2dfff197/widechars.patch";
        sha256 = "0qa0dv9v9g4vqbsvg2ifgxli0ii4qcqi8zdlyljdbjg3aar65yx0";
      })
      (super.fetchpatch {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/misc/rxvt_unicode/rxvt-unicode-9.06-font-width.patch";
        sha256 = "08nxlavrw78l6n4cc6fxl8wd281wa5nb26w657g8zwkih920nj36";
      })
    ];
  });
}
