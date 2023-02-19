{ lib
, rustPlatform
, fetchCrate
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "xq";
  version = "0.2.42";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-VR2ZUt0qvQBaFZr7Gui/LywsRrPubQlzYj1PQj05xhY=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Pure rust implementation of jq";
    homepage = "https://github.com/MiSawa/xq";
    license = licenses.mit;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
