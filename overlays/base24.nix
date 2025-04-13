{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "base24-schemes";
  # version = "unstable-2024-11-12";

  src = fetchFromGitHub {
    owner = "tinted-theming";
    repo = "schemes";
    # rev = "61058a8d2e2bd4482b53d57a68feb56cdb991f0b";
    sha256 = "";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes/
    install base24/*.yaml $out/share/themes/

    runHook postInstall
  '';
})
