{ lib
, fetchFromGitHub
, rustPlatform
, pkg-config
, openssl
, dbus
, sqlite
, file
, makeWrapper
}:

rustPlatform.buildRustPackage rec {
  pname = "krankerl";
  version = "0.14.0";

  src = fetchFromGitHub {
    owner = "ChristophWurst";
    repo = "krankerl";
    rev = "v${version}";
    sha256 = "sha256-fFtjQFkNB5vn9nlFJI6nRdqxB9PmOGl3ySZ5LG2tgPg=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    openssl
    dbus
    sqlite
  ];

  nativeCheckInputs = [
    file
  ];

  meta = with lib; {
    description = "A CLI helper to manage, package and publish Nextcloud apps";
    homepage = "https://github.com/ChristophWurst/krankerl";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ onny ];
  };
}
