# nuvio-flatpak-repo

## Install
```
flatpak remote-add --user --no-gpg-verify nuvio-repo https://douglascdev.github.io/nuvio-flatpak-repo/repo/
flatpak install com.nuvio.media.desktop
```

## Dev
```
nix develop
rm Nuvio-Linux*
nix run .#import-bundle
```
