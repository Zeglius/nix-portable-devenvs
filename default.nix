{ pkgs ? import <nixpkgs> { }, lib, programs ? [ null ] }:

let
  fhs =
    let name = "myenv";
    in (pkgs.buildFHSEnv {
      inherit name;
      targetPkgs = (p: (with p; [ bash ]) ++ programs);
      runScript = "bash";
    }) // {
      meta.mainProgram = "${name}";
    };

in
pkgs.writeShellApplication {
  inherit (fhs) name;
  text = ''
    exec ${lib.getExe fhs}
  '';
}

## Or

# pkgs.buildEnv {
#   name = "my-packages";
#   paths = with pkgs; [
#     aspell
#     bc
#     coreutils
#     gdb
#     ffmpeg
#     emscripten
#     jq
#     nox
#     silver-searcher
#   ];
# }

## Or

# pkgs.mkShellNoCC {
#   packages = with pkgs; [
#     aspell
#     bc
#     coreutils
#     gdb
#     ffmpeg
#     emscripten
#     jq
#     nox
#     silver-searcher
#   ];
# }
