{ fetchCrate
, installShellFiles
, lib
, libbsd
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "inputplug";
  version = "0.4.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "00gv2i2pxy56l6ysslbscxinr4r0mpk9p2ivkrnjnwhc8j3v8v7h";
  };

  nativeBuildInputs = [ installShellFiles pkg-config ];

  buildInputs = [ libbsd ];

  cargoLock.lockFile = ./Cargo.lock;

  postInstall = ''
    installManPage inputplug.1
  '';

  meta = with lib; {
    description = "Monitor XInput events and run arbitrary scripts on hierarchy change events";
    homepage = "https://github.com/andrewshadura/inputplug";
    license = licenses.mit;
    maintainers = with maintainers; [ jecaro ];
  };
}
