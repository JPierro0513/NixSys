{
  fetchFromGitHub,
  rustPlatform,
  pkgs,
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

  nativeBuildInputs = with pkgs; [pkg-config openssl];
}
