{ lib
, rustPlatform
, fetchCrate
, pkg-config
, libusb1
, stdenv
, AppKit
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-hf2";
  version = "0.3.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-0o3j7YfgNNnfbrv9Gppo24DqYlDCxhtsJHIhAV214DU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ libusb1 ] ++ lib.optionals stdenv.isDarwin [ AppKit ];

  meta = with lib; {
    description = "Cargo Subcommand for Microsoft HID Flashing Library for UF2 Bootloaders ";
    homepage = "https://lib.rs/crates/cargo-hf2";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ astrobeastie ];
  };
}
