self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.2.3";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "004bp77gpvjsr264p0kwkzmpc3ksh5s0m58m4n6pjqx29p5m2mhq";
    };
  });
}
