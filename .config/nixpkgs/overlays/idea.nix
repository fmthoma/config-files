self: super: {
  idea-ultimate = super.jetbrains.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2019.1.1";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "0x7jba5h3wizkqyr1in7igzczz2ycnampis3i5k57slc1pvv4mlb";
    };
  });
}
