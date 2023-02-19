{ lib
, stdenv
, fetchpatch
, fetchFromGitHub
, nix-update-script
, rustPlatform
, CoreServices
, which
}:

rustPlatform.buildRustPackage rec {
  pname = "dotter";
  version = "0.12.14";

  src = fetchFromGitHub {
    owner = "SuperCuber";
    repo = "dotter";
    rev = "v${version}";
    hash = "sha256-GGbUpjAcihJLNNo0OtkRGQ2RcT/75vDABlHs7Atzo1s=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = lib.optionals stdenv.isDarwin [ CoreServices ];

  nativeCheckInputs = [ which ];

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "A dotfile manager and templater written in rust 🦀";
    homepage = "https://github.com/SuperCuber/dotter";
    license = licenses.unlicense;
    maintainers = with maintainers; [ linsui ];
  };
}
