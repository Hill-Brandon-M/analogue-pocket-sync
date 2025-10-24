{
  appimageTools,
  fetchurl,
  lib,
  ...
}:

let
  pname = "Analogue Pocket-Sync";
  version = "5.9.1";

  src = fetchurl {
    url = "https://github.com/neil-morrison44/pocket-sync/releases/download/v${version}/Pocket.Sync_${version}_amd64.AppImage";
    hash = "sha256-836cef56ae11e595d2bfe2c3c071a1a0c37fd5896400ed446097234f82a1558a";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };

in appimageTools.wrapType2 rec {
  
  inherit pname version src;
  pkgs = pkgs;

  extraInstallCommands = ''
    
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "A GUI tool (Mac, Windows, Linux) for doing stuff with the Analogue Pocket";
    homepage = "https://github.com/neil-morrison44/pocket-sync";
    downloadPage = "https://github.com/neil-morrison44/pocket-sync/releases";
    license = lib.licenses.gpl3;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    # maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}