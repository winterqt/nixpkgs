{ lib
, fetchFromGitHub
, rustPlatform
, dbus
, pkg-config
, openssl
, libevdev
}:

rustPlatform.buildRustPackage rec {
  pname = "tp-auto-kbbl";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "saibotd";
    repo = pname;
    rev = version;
    sha256 = "0db9h15zyz2sq5r1qmq41288i54rhdl30qy08snpsh6sx2q4443y";
  };

  cargoLock.lockFile = ./Cargo.lock;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ dbus libevdev openssl ];

  meta = with lib; {
    description = "Auto toggle keyboard back-lighting on Thinkpads (and maybe other laptops) for Linux";
    homepage = "https://github.com/saibotd/tp-auto-kbbl";
    license = licenses.mit;
    maintainers = with maintainers; [ sebtm ];
    platforms = platforms.linux;
  };
}
