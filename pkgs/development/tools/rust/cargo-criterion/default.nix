{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-criterion";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "bheisler";
    repo = pname;
    rev = version;
    sha256 = "sha256-RPix9DM6E32PhObvV3xPGrnXrrVHn3auxLUhysP8GM0=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Cargo extension for running Criterion.rs benchmarks";
    homepage = "https://github.com/bheisler/cargo-criterion";
    license = with licenses; [ asl20 /* or */ mit ];
    maintainers = with maintainers; [ humancalico ];
  };
}
