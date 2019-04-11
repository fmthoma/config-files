self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.3.6";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "1s4llbkf12i3h7i0k3bvbq21m9mk5ja34w59m1vs75f2cq1d06yw";
    };
  });
}
