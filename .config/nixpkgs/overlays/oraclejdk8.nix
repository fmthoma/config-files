self: super: {
  oraclejdk8 = super.oraclejdk8.override { installjce = true; };
}
