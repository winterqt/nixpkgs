{ lib
, stdenv
, rustPlatform
, fetchFromGitHub
, SystemConfiguration
, python3
}:

rustPlatform.buildRustPackage rec {
  pname = "rustpython";
  version = "unstable-2022-10-11";

  src = fetchFromGitHub {
    owner = "RustPython";
    repo = "RustPython";
    rev = "273ffd969ca6536df06d9f69076c2badb86f8f8c";
    sha256 = "sha256-t/3++EeP7a8t2H0IEPLogBri7+6u+2+v+lNb4/Ty1/w=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "rustpython-doc-0.1.0" = "sha256-aVc2WMxJ1Z1+iMuigdn8+Yp4DnpGenoqvDoJMAiHIgU=";
    };
  };

  # freeze the stdlib into the rustpython binary
  cargoBuildFlags = [ "--features=freeze-stdlib" ];

  buildInputs = lib.optionals stdenv.isDarwin [ SystemConfiguration ];

  nativeCheckInputs = [ python3 ];

  meta = with lib; {
    description = "Python 3 interpreter in written Rust";
    homepage = "https://rustpython.github.io";
    license = licenses.mit;
    maintainers = with maintainers; [ prusnak ];
  };
}
