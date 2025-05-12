{
  programs.niri.settings.window-rules = [
      {
        draw-border-with-background = false;
        clip-to-geometry = true;

        geometry-corner-radius = let radius = 12.0; in {
	  bottom-left = radius;
	  bottom-right = radius;
	  top-left = radius;
	  top-right = radius;
	};
      }
    ];
}
