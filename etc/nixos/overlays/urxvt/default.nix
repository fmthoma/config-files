self: super: {
  rxvt_unicode = super.rxvt_unicode.overrideAttrs (oldAttrs : {
    patches = [
      (super.fetchpatch {
        url = "https://gist.githubusercontent.com/fmthoma/7e8dd23c12b55cae6474/raw/78378cf5e175d0d07f645d7ba0dd437e2dfff197/widechars.patch";
        sha256 = "0mjxqm5zfb4108jxkfmqmfn9v84bg6a6s3w7knni6x5zwsx1xykk";
      })
      (super.fetchpatch {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/20.03/pkgs/applications/misc/rxvt-unicode/patches/9.06-font-width.patch";
        sha256 = "08nxlavrw78l6n4cc6fxl8wd281wa5nb26w657g8zwkih920nj36";
      })
    ];
  });
}
