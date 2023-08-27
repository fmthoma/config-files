self: super: {
    rofi = super.rofi.override {
        plugins = [
            self.pkgs.rofi-calc
            self.pkgs.rofi-emoji
        ];
    };
}
