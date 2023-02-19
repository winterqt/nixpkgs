{ lib
, stdenv
, rustPlatform
, fetchFromGitHub
, IOKit
, nvidiaSupport ? false
, makeWrapper
, llvmPackages
}:

assert nvidiaSupport -> stdenv.isLinux;

rustPlatform.buildRustPackage rec {
  pname = "zenith";
  version = "0.13.1";

  src = fetchFromGitHub {
    owner = "bvaisvil";
    repo = pname;
    rev = version;
    sha256 = "sha256-N/DvPVYGM/DjTvKvOlR60q6rvNyfAQlnvFnFG5nbUmQ=";
  };

  # remove cargo config so it can find the linker on aarch64-linux
  postPatch = ''
    rm .cargo/config
  '';

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "heim-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-common-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-cpu-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-disk-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-host-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-memory-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-net-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-process-0.1.1-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-runtime-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-sensors-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "heim-virt-0.1.0-rc.1" = "sha256-os4KumOEhtCPMlsiZif5EFswjLAHw+nuqDaCEFYcs8A=";
      "sysinfo-0.15.1" = "sha256-sOHd8x0M5gJGHHcK6RQWelEl1sZkQs9iUChM/hH12bM=";
    };
  };

  nativeBuildInputs = [ llvmPackages.clang ] ++ lib.optional nvidiaSupport makeWrapper;
  buildInputs = [ llvmPackages.libclang ] ++ lib.optionals stdenv.isDarwin [ IOKit ];

  buildFeatures = lib.optional nvidiaSupport "nvidia";

  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

  postInstall = lib.optionalString nvidiaSupport ''
    wrapProgram $out/bin/zenith \
      --suffix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
  '';

  meta = with lib; {
    description = "Sort of like top or htop but with zoom-able charts, network, and disk usage"
      + lib.optionalString nvidiaSupport ", and NVIDIA GPU usage";
    homepage = "https://github.com/bvaisvil/zenith";
    license = licenses.mit;
    maintainers = with maintainers; [ bbigras ];
    platforms = platforms.unix;
  };
}
