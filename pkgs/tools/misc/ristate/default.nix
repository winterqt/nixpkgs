{ lib, rustPlatform, fetchFromGitLab }:

rustPlatform.buildRustPackage rec {
  pname = "ristate";
  version = "unstable-2021-09-10";

  src = fetchFromGitLab {
    owner = "snakedye";
    repo = pname;
    rev = "34dfd0a0bab5b36df118d8da3956fd938c625b15";
    sha256 = "sha256-CH9DZ/7Bhbe6qKg1Nbj1rA9SzIsqVlBJg51XxAh0XnY=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A river-status client written in Rust";
    homepage = "https://gitlab.com/snakedye/ristate";
    license = licenses.mit;
    maintainers = with maintainers; [ kranzes ];
  };
}
