{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "angle-grinder";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "rcoh";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-kohw95pvcBLviPgTDGWIbvZuz1cJmKh4eB0Bx4AEk1E=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Slice and dice logs on the command line";
    homepage = "https://github.com/rcoh/angle-grinder";
    license = licenses.mit;
    maintainers = with maintainers; [ bbigras ];
    mainProgram = "agrind";
  };
}
