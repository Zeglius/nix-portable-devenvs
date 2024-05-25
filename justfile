#!/usr/bin/env -S just --justfile

_default:
    just --list

bundle:
    nix bundle --bundler github:DavHau/nix-portable -o bundle

fmt:
    nixpkgs-fmt $(find ./ -name '*.nix')

clean:
    #!/usr/bin/env bash
    set -euxo pipefail

    nixsyms=(./bundle ./result)

    storepaths=()
    for path in "${nixsyms[@]}"; do
        if [[ -L $path ]]; then
            a=$(readlink $path)
            storepaths+=($(readlink $path))
            echo $a
            unset -v a
        fi
    done
    rm "${nixsyms[@]}" || true
    {
        [[ -n "${storepaths[*]}" ]] && nix store delete "${storepaths[@]}"
    } || true
