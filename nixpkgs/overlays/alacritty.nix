self: super: {
  alacritty-gl = super.alacritty.overrideAttrs(oldAttrs: {
   buildInputs = (oldAttrs.buildInputs or []) ++ [ self.mesa.drivers self.libglvnd ];
   postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/alacritty \
        --set LD_LIBRARY_PATH "${self.libglvnd}/lib:${self.mesa.drivers}/lib"
    '';
  });
}
