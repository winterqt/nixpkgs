{ lib
, stdenv
, fetchFromGitHub
, openssl
, pkg-config
, rustPlatform
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "coinlive";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "mayeranalytics";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-llw97jjfPsDd4nYi6lb9ug6sApPoD54WlzpJswvdbRs=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    Security
  ];

  checkFlags = [
    # requires network access
    "--skip=utils::test_get_infos"
  ];

  meta = with lib; {
    description = "Live cryptocurrency prices CLI";
    homepage = "https://github.com/mayeranalytics/coinlive";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ fab ];
  };
}
