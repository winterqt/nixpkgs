{ fetchFromGitHub, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "nomino";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "yaa110";
    repo = pname;
    rev = version;
    sha256 = "sha256-XUxoHmZePn/VVlu2KctC+TbmCwp+tYEYg5EYXI8ZB7o=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "Batch rename utility for developers";
    homepage = "https://github.com/yaa110/nomino";
    license = with licenses; [ mit /* or */ asl20 ];
    maintainers = with maintainers; [ figsoda ];
  };
}
