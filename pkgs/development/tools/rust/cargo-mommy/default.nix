{ lib, rustPlatform, fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-mommy";
  version = "0.1.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-p1SAYUQu1HpYJ6TbLJ3lfA9VlKHvB7z5yiFXmTQOCXA=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Cargo wrapper that encourages you after running commands";
    homepage = "https://github.com/Gankra/cargo-mommy";
    license = with licenses; [ mit asl20 ];
    maintainers = with maintainers; [ GoldsteinE ];
  };
}
