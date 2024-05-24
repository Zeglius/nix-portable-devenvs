{ pkgs ? import <nixpkgs> { } }:

let 
  fhs = (pkgs.buildFHSEnv {
  name = "myenv";
  targetPkgs = (p: with p; [ bash htop ]);
  runScript = "bash";
});

in pkgs.writeShellApplication {
  inherit (fhs) name;
  runtimeInputs = [ fhs ];
  text = ''
    exec myenv
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
