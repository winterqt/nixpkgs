{ fetchCrate, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "clini";
  version = "0.1.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-+HnoYFRG7GGef5lV4CUsUzqPzFUzXDajprLu25SCMQo=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "A simple tool to do basic modification of ini files";
    homepage = "https://github.com/domgreen/clini";
    license = licenses.mit;
    maintainers = with maintainers; [ Flakebi ];
  };
}
