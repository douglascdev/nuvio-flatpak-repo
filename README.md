# nuvio-flatpak-repo

## Install
```
flatpak remote-add --user nuvio-repo https://douglascdev.github.io/nuvio-flatpak-repo/nuvio.flatpakrepo
flatpak install com.nuvio.media.desktop
```

## Dev
```
nix develop
rm Nuvio-Linux*
nix run .#import-bundle
```

