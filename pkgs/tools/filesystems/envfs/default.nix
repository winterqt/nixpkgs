{ rustPlatform, lib, fetchFromGitHub, nixosTests }:
rustPlatform.buildRustPackage rec {
  pname = "envfs";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "envfs";
    rev = version;
    hash = "sha256-aF8V1LwPGifFWoVxM0ydOnTX1pDVJ6HXevTxADJ/rsw=";
  };
  cargoLock.lockFile = ./Cargo.lock;

  passthru.tests = {
    envfs = nixosTests.envfs;
  };

  postInstall = ''
    ln -s envfs $out/bin/mount.envfs
    ln -s envfs $out/bin/mount.fuse.envfs
  '';
  meta = with lib; {
    description = "Fuse filesystem that returns symlinks to executables based on the PATH of the requesting process.";
    homepage = "https://github.com/Mic92/envfs";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.linux;
  };
}
