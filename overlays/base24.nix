{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  name = "base24-schemes";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "tinted-theming";
    repo = "schemes";
    rev = "5dc50019e932e772f4f8e2d8af8ca9ca202b9bdd";
    sha256 = "sha256-WAt2QPvv/gy9oTpk0iUJOxB0rDLE+vqLD3a7k9wcOvE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/
    install base24/*.yaml $out/share/themes/

    runHook postInstall
  '';
})
