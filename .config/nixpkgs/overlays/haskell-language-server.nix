self: super: {
    haskell-language-server = super.haskell-language-server.override {
        supportedGhcVersions =  [ "884" "8107" ];
    };
}
