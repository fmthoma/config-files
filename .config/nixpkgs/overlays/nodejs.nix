self: super: {
    yarn-12_x = super.yarn.override { nodejs = self.nodejs-12_x; };
    yarn-16_x = super.yarn.override { nodejs = self.nodejs-16_x; };
}
