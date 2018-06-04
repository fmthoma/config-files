self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.1.4";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "1122dhk7ad3a8iw7fs55kg7cjj657hcxbk2ykhd3x0h2759y25pv";
    };
  });
}
