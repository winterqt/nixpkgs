{ lib, stdenv, fetchFromGitHub, rustPlatform, Security }:

rustPlatform.buildRustPackage rec {
  pname = "xsv";
  version = "0.13.0";

  src = fetchFromGitHub {
    owner = "BurntSushi";
    repo = "xsv";
    rev = version;
    sha256 = "17v1nw36mrarrd5yv4xd3mpc1d7lvhd5786mqkzyyraf78pjg045";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = lib.optional stdenv.isDarwin Security;

  meta = with lib; {
    description = "A fast CSV toolkit written in Rust";
    homepage = "https://github.com/BurntSushi/xsv";
    license = with licenses; [ unlicense /* or */ mit ];
    maintainers = [ maintainers.jgertm ];
  };
}
