self: super: {
  idea-ultimate = super.idea.idea-ultimate.overrideAttrs (oldAttrs: rec {
    name = "idea-ultimate-${version}";
    version = "2018.3.2";
    src = super.fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIU-${version}.tar.gz";
      sha256 = "195phvrigy7nbdhqwkniiqd9vq2crf7spms9y7f7g8m59pyc8pc8";
    };
  });
}
