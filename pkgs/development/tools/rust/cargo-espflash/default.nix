{ lib, rustPlatform, fetchFromGitHub, pkg-config, udev, stdenv, Security }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-espflash";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "esp-rs";
    repo = "espflash";
    rev = "v${version}";
    sha256 = "sha256-AauIneSnacnY4mulD/qUgfN4K9tLzZXFug0oEsDuj18=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    udev
  ] ++ lib.optionals stdenv.isDarwin [
    Security
  ];

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Serial flasher utility for Espressif SoCs and modules based on esptool.py";
    homepage = "https://github.com/esp-rs/cargo-espflash";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ matthiasbeyer ];
  };
}
