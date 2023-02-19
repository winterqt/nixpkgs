{ stdenv
, lib
, fetchFromGitLab
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "gitlab-clippy";
  version = "1.0.3";

  src = fetchFromGitLab {
    owner = "dlalic";
    repo = pname;
    rev = version;
    sha256 = "sha256-d7SmlAWIV4SngJhIvlud90ZUSF55FWIrzFpkfSXIy2Y=";
  };
  cargoLock.lockFile = ./Cargo.lock;

  # TODO re-add theses tests once they get fixed in upstream
  checkFlags = [
    "--skip cli::converts_error_from_pipe"
    "--skip cli::converts_warnings_from_pipe"
  ];

  meta = {
    homepage = "https://gitlab.com/dlalic/gitlab-clippy";
    description = "Convert clippy warnings into GitLab Code Quality report";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ wucke13 ];
  };
}
