{ dbus
, fetchFromGitHub
, lib
, pkg-config
, rustPlatform
}:
let
  version = "0.1.1";
in
rustPlatform.buildRustPackage {
  pname = "gnome-randr";
  inherit version;

  src = fetchFromGitHub {
    owner = "maxwellainatchi";
    repo = "gnome-randr-rust";
    rev = "v" + version;
    sha256 = "sha256-mciHgBEOCFjRA4MSoEdP7bIag0KE+zRbk4wOkB2PAn0=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  buildInputs = [ dbus ];

  nativeBuildInputs = [ pkg-config ];

  meta = {
    description = "An xrandr-like CLI for configuring displays on GNOME/Wayland, on distros that don't support `wlr-randr`";
    homepage = "https://github.com/maxwellainatchi/gnome-randr-rust";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.roberth ];
  };
}
