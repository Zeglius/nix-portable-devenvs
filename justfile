#!/usr/bin/env -S just --justfile

_default:
    just --list

bundle:
    nix bundle --bundler github:DavHau/nix-portable -o bundle
