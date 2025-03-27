{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "thundery";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "loefey";
    repo = "thundery";
    rev = "${version}";
    sha256 = "sha256-8VM9o2OqbYlT1kNQXygGQp8O4QPugy+GcmkQhWwUAu0=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-wqtv77aAJTRUSs5ZjqMouuzeDW2O7wg0JsLgoKnpJ5U=";

  nativeBuildInputs = [pkg-config openssl];

  PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";

  # meta = with lib; {
  #   description = "a weather fetching cli based off rainy";
  #   mainProgram = "thundery";
  #   homepage = "https://github.com/loefey/thundery";
  #   license = licenses.gpl3;
  #   # maintainers = with maintainers; [];
  # };
}
