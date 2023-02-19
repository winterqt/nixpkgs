{ lib
, fetchCrate
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "vopono";
  version = "0.10.4";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-a9u8Ywxrdo4FFggotL8L5o5eDDu+MtcMVBG+jInXDVs=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Run applications through VPN connections in network namespaces";
    homepage = "https://github.com/jamesmcm/vopono";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
