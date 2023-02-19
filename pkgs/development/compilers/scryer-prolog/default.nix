{ stdenv
, lib
, fetchFromGitHub
, rustPlatform
, rustfmt
, gmp
, libmpc
, mpfr
, openssl
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "scryer-prolog";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "mthom";
    repo = "scryer-prolog";
    rev = "v${version}";
    sha256 = "bDLVOXX9nv6Guu5czRFkviJf7dBiaqt5O8SLUJlcBZo=";
  };

  cargoPatches = [
    # Use system openssl, gmp, mpc and mpfr.
    ./cargo.patch
  ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "modular-bitfield-0.11.2" = "sha256-vcx+xt5owZVWOlKwudAr0EB1zlLLL5pVfWokw034BQI=";
      "modular-bitfield-impl-0.11.2" = "sha256-vcx+xt5owZVWOlKwudAr0EB1zlLLL5pVfWokw034BQI=";
    };
  };

  nativeBuildInputs = [ pkg-config rustfmt];
  buildInputs = [ openssl gmp libmpc mpfr ];

  meta = with lib; {
    broken = stdenv.isDarwin;
    description = "A modern Prolog implementation written mostly in Rust.";
    homepage = "https://github.com/mthom/scryer-prolog";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ malbarbo ];
  };
}
