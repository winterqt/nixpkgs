{ lib, rustPlatform, fetchCrate, stdenv, Security }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-supply-chain";
  version = "0.3.2";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-0WyaenLyD1MNkV+mzCIodhtkU6FqbGnuTdw6PvzIrVU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = lib.optional stdenv.isDarwin Security;

  meta = with lib; {
    description = "Gather author, contributor and publisher data on crates in your dependency graph";
    homepage = "https://github.com/rust-secure-code/cargo-supply-chain";
    changelog = "https://github.com/rust-secure-code/cargo-supply-chain/blob/master/CHANGELOG.md";
    license = with licenses; [ asl20 mit zlib ]; # any of three
    maintainers = with maintainers; [ figsoda ];
  };
}
