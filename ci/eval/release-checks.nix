{
  lib,
  runCommand,
  attrpathsSuperset,
  nixpkgs,
  singleSystem,
  linkFarm,
}:

{
  evalSystem,
  chunkSize,
}:

let
  abortSource = builtins.toFile "dont-use-nix-path-in-nixpkgs.nix" ''
    builtins.abort "Illegal use of <nixpkgs> in Nixpkgs"
  '';

  addAbortSourceToEnv = oldAttrs: {
    env = (oldAttrs.env or { }) // {
      NIX_PATH = "nixpkgs=${abortSource}";
    };
  };

  nixpkgs' = builtins.path {
    name = "nixpkgs-prime";
    path = nixpkgs;
  };

  attrpaths = (attrpathsSuperset { inherit evalSystem; }).overrideAttrs addAbortSourceToEnv;

  attrpaths' =
    (attrpathsSuperset {
      inherit evalSystem;
      nixpkgsPath = nixpkgs';
    }).overrideAttrs
      addAbortSourceToEnv;

  # TODO(winter): The release checks also consist of
  # a separate eval with `--meta` set. Is this any
  # use to us? Throughout my testing I couldn't find
  # an issue that the outpath eval alone didn't catch.
  evalOptions = {
    inherit evalSystem chunkSize;
    attrpathFile = "${attrpaths}/paths.json";

    # Don't try to eval broken or unfree packages.
    # TODO(winter): Consider enabling unfree eval with platform checks (context: pkgs.airtame)
    includeBroken = false;

    # This is a misnomer, as we still catch and detect packages that aren't in a
    # package's `meta.platforms`, but we still want to try and eval it to make
    # sure that we can even get to the unsupported `throw`. (See
    # https://github.com/NixOS/nixpkgs/pull/406207 as an example where the broken
    # `throw` wasn't reached, therefore breaking `nixpkgs-review`.)
    includeUnsupported = true;
  };

  eval = (singleSystem evalOptions).overrideAttrs addAbortSourceToEnv;

  eval' =
    (singleSystem (
      evalOptions
      // {
        nixpkgsPath = nixpkgs';
      }
    )).overrideAttrs
      addAbortSourceToEnv;

  checks = {
    badFiles = runCommand "bad-files-check" { } ''
      badFiles=$(find ${nixpkgs}/pkgs -type f -name '*.nix' -print | xargs grep -l '^[^#]*<nixpkgs/' || true)
      if [[ -n $badFiles ]]; then
        echo "Nixpkgs is not allowed to use <nixpkgs> to refer to itself."
        echo "The offending files: $badFiles"
        exit 1
      fi

      touch "$out"
    '';

    conflictingPaths = runCommand "conflicting-files-check" { } ''
      conflictingPaths=$(find ${nixpkgs} | awk '{ print $1 " " tolower($1) }' | sort -k2 | uniq -D -f 1 | cut -d ' ' -f 1)
      if [[ -n $conflictingPaths ]]; then
        echo "Files in nixpkgs must not vary only by case"
        echo "The offending paths: $conflictingPaths"
        exit 1
      fi

      touch "$out"
    '';

    evalPurity = runCommand "eval-purity-check" { } ''
      if ! diff -u ${eval}/paths ${eval'}/paths; then
        echo
        echo "Error: Nixpkgs evaluation depends on Nixpkgs path"
        exit 1
      fi

      touch "$out"
    '';

  };
in
(linkFarm "release-checks-${evalSystem}" (
  lib.mapAttrsToList (_: check: {
    inherit (check) name;
    path = check;
  }) checks
))
// checks
// {
  inherit eval;
}
