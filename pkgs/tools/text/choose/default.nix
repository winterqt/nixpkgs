{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "choose";
  version = "1.3.4";

  src = fetchFromGitHub {
    owner = "theryangeary";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-yW1quDyQn2xhrlhhPj9DKq7g8LlYKvEKDFj3xSagRTU=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A human-friendly and fast alternative to cut and (sometimes) awk";
    homepage = "https://github.com/theryangeary/choose";
    license = licenses.gpl3;
    maintainers = with maintainers; [ sohalt ];
  };
}
