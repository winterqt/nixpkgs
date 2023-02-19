{ lib, rustPlatform, fetchCrate, pkg-config, gtk4 }:

rustPlatform.buildRustPackage rec {
  pname = "ripdrag";
  version = "0.2.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-/TF9dWZQVEVM3lHp4ubxYkDW+ZDL9puT6mUT6Q3hUsw=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ gtk4 ];

  meta = with lib; {
    description = "An application that lets you drag and drop files from and to the terminal";
    homepage = "https://github.com/nik012003/ripdrag";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ figsoda ];
  };
}
