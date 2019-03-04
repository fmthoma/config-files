self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.3.5";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "0y6h80cb9wh0jnzx06m8gq5hvlv3j2yz748ii61qyqr16mfdm5mn";
    };
  });
}
