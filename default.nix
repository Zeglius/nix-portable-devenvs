{ pkgs ? import <nixpkgs> { }, programs ? [ null ] }:

let
  fhs =
    let name = "myenv";
    in (pkgs.buildFHSEnv {
      inherit name;
      targetPkgs = (p: (with p; [ bash ]) ++ programs);
      runScript = "bash";
    }) // {
      meta.manProgram = "${name}";
    };

in
pkgs.writeShellApplication {
  inherit (fhs) name;
  runtimeInputs = [ fhs ];
  text = ''
    exec ${fhs.name}
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
