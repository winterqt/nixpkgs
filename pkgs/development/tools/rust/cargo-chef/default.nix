{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-chef";
  version = "0.1.51";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-K9oryItevSABbklaX5KKvKHuebFX8B0AgnizlpDhM5o=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A cargo-subcommand to speed up Rust Docker builds using Docker layer caching";
    homepage = "https://github.com/LukeMathWalker/cargo-chef";
    license = licenses.mit;
    maintainers = with maintainers; [ kkharji ];
  };
}
