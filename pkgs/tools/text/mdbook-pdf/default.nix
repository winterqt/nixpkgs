{ lib
, stdenv
, fetchCrate
, rustPlatform
, pkg-config
, openssl
, CoreServices
}:

rustPlatform.buildRustPackage rec {
  pname = "mdbook-pdf";
  version = "0.1.5";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-822RQKgedxQ+VFNDv20tFUc2Xl56Ivub+/EXNrLRfGM=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    CoreServices
  ];

  # No test.
  doCheck = false;

  meta = with lib; {
    description = "A backend for mdBook written in Rust for generating PDF";
    homepage = "https://github.com/HollowMan6/mdbook-pdf";
    changelog = "https://github.com/HollowMan6/mdbook-pdf/releases/tag/v${version}";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ hollowman6 ];
  };
}
