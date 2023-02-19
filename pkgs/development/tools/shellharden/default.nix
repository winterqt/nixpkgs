{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "shellharden";
  version = "4.3.0";

  src = fetchFromGitHub {
    owner = "anordal";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-yOfGMxNaaw5ub7woShDMCJNiz6FgV5IBJN87VmORLvg=";
  };

  cargoLock.lockFile = ./Cargo.lock;

  postPatch = "patchShebangs moduletests/run";

  meta = with lib; {
    description = "The corrective bash syntax highlighter";
    longDescription = ''
      Shellharden is a syntax highlighter and a tool to semi-automate the
      rewriting of scripts to ShellCheck conformance, mainly focused on quoting.
    '';
    homepage = "https://github.com/anordal/shellharden";
    license = licenses.mpl20;
    maintainers = with maintainers; [ oxzi ];
  };
}
