{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, dtc, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "cloud-hypervisor";
  version = "29.0";

  src = fetchFromGitHub {
    owner = "cloud-hypervisor";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-UH5HGXTRYcCBGhswHpGAn8a7rfl5j7gF8GgdpGj5Cb8=";
  };

  separateDebugInfo = true;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optional stdenv.isAarch64 dtc;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "kvm-bindings-0.6.0" = "sha256-QS8Rd05BmWf/juWKdjnj1aVDi69fCVVHrxpOzPVLCLQ=";
      "micro_http-0.1.0" = "sha256-kI7Q0vY+DpkjK7M9ll70hah8ubZv6tpGp8NSR6lyw38=";
      "mshv-bindings-0.1.1" = "sha256-uioAk7RdyGd8dN/dJz8OFmBBPma0B4YvBH/R8KpTPS4=";
      "mshv-ioctls-0.1.1" = "sha256-uioAk7RdyGd8dN/dJz8OFmBBPma0B4YvBH/R8KpTPS4=";
      "versionize_derive-0.1.4" = "sha256-1PVpNEBAIyLFIchgd8gbXVBIs7z8okJf7zyjCOlhrdU=";
      "vfio-bindings-0.4.0" = "sha256-0QVBDWqj5kaw7jiqnM5ZB2dUhdCe5By2U2h1Gd7bU+U=";
      "vfio-ioctls-0.2.0" = "sha256-0QVBDWqj5kaw7jiqnM5ZB2dUhdCe5By2U2h1Gd7bU+U=";
      "vm-fdt-0.2.0" = "sha256-ebyEFceRYSG3vYgmPG8JNzVggeDKoqOyzHGaf/t2uCM=";
    };
  };

  OPENSSL_NO_VENDOR = true;

  # Integration tests require root.
  cargoTestFlags = [ "--bins" ];

  meta = with lib; {
    homepage = "https://github.com/cloud-hypervisor/cloud-hypervisor";
    description = "Open source Virtual Machine Monitor (VMM) that runs on top of KVM";
    changelog = "https://github.com/cloud-hypervisor/cloud-hypervisor/releases/tag/v${version}";
    license = with licenses; [ asl20 bsd3 ];
    maintainers = with maintainers; [ offline qyliss ];
    platforms = [ "aarch64-linux" "x86_64-linux" ];
  };
}
