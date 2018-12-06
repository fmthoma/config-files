self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.2.7";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "024ibj8d3j93rhblnddkh1rsnrg1yf5jgbwx12kz03r3mf4pxzss";
    };
  });
}
