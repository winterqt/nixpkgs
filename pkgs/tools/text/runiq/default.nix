{ fetchCrate, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "runiq";
  version = "1.2.2";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-WPQgTQICZ0DFr+7D99UGMx+I78376IC6iIJ3tCsj0Js=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  meta = with lib; {
    description = "An efficient way to filter duplicate lines from input, à la uniq";
    homepage = "https://github.com/whitfin/runiq";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
