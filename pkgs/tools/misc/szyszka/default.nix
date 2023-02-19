{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, glib
, cairo
, pango
, atk
, gdk-pixbuf
, gtk3
}:

rustPlatform.buildRustPackage rec {
  pname = "szyszka";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "qarmin";
    repo = pname;
    rev = version;
    sha256 = "sha256-TQwDvkWWlk09kVVaVI56isJi+X9UXWnoz+2PVyK9BGc=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    glib
    cairo
    pango
    atk
    gdk-pixbuf
    gtk3
  ];

  meta = with lib; {
    description = "A simple but powerful and fast bulk file renamer";
    homepage = "https://github.com/qarmin/szyszka";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ kranzes ];
  };
}
