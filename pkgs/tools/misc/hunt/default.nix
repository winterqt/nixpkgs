{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "hunt";
  version = "1.7.6";

  src = fetchFromGitHub {
    owner = "LyonSyonII";
    repo = "hunt-rs";
    rev = "v${version}";
    sha256 = "sha256-mNQY2vp4wNDhVqrFNVS/RBXVi9EMbTZ6pE0Z79dLUeM=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Simplified Find command made with Rust";
    homepage = "https://github.com/LyonSyonII/hunt";
    license = licenses.mit;
    maintainers = with maintainers; [ dit7ya ];
  };
}
