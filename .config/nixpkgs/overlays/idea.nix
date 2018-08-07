self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.1.6";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "09idn5i66c6z8kdw4xdfqnd5cj7krs5ngw9mik1vxaj9m2bnks7k";
    };
  });
}
