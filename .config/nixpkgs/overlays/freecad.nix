self: super: {
    freecad = super.freecad.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = [self.openscad];
    });
}
