{
  appimageTools,
  fetchurl,
  lib,
  ...
}:

let
  pname = "analogue-pocket-sync";
  version = "5.9.1";

  src = fetchurl {
    url = "https://github.com/neil-morrison44/pocket-sync/releases/download/v${version}/Pocket.Sync_${version}_amd64.AppImage";
    hash = "sha256-g2zvVq4R5ZXSv+LDwHGhoMN/1YlkAO1EYJcjT4KhVYo=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

in appimageTools.wrapType2 rec {
  
  inherit pname version src;
  pkgs = pkgs;

  extraInstallCommands = ''
    
    install -m 444 -D ${appimageContents}/"Pocket Sync.desktop" -t $out/share/applications
    
    substituteInPlace $out/share/applications/"Pocket Sync.desktop" \
      --replace 'Exec=pocket-sync' 'Exec=${pname}'
    
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    name = "Analogue Pocket-Sync";
    description = "A GUI tool (Mac, Windows, Linux) for doing stuff with the Analogue Pocket";
    homepage = "https://github.com/neil-morrison44/pocket-sync";
    downloadPage = "https://github.com/neil-morrison44/pocket-sync/releases";
    license = lib.licenses.gpl3;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}