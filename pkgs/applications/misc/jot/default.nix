{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "jot";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "araekiel";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-CgS9I05Om4JxAbPN0vxh2Y7dftIkVnZkRP7PY4kOfpw=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Rapid note management for the terminal";
    homepage = "https://github.com/araekiel/jot";
    license = licenses.mit;
    maintainers = with maintainers; [ dit7ya ];
    mainProgram = "jt";
  };
}
