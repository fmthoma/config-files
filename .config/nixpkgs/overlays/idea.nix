self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.2.4";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "1l5p6wv9hsgrvm91hfdm30qwzkinkhrz57w23cl7ff37ghr2dh78";
    };
  });
}
