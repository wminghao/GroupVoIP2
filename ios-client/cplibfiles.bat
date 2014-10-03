mkdir vlclibs
cd vlclibs
mkdir Release-iphoneos
cp -r ~/GroupVoIP.VLCKitIOS/build/Release-iphoneos/libMobileVLCKit.a Release-iphoneos
mkdir Release-iphonesimulator
cp -r ~/GroupVoIP.VLCKitIOS/build/Release-iphonesimulator/libMobileVLCKit.a Release-iphonesimulator
mkdir Debug-iphoneos
cp -r ~/GroupVoIP.VLCKitIOS/build/Debug-iphoneos/libMobileVLCKit.a Debug-iphoneos
mkdir Debug-iphonesimulator
cp -r ~/GroupVoIP.VLCKitIOS/build/Debug-iphonesimulator/libMobileVLCKit.a Debug-iphonesimulator
cp -r ~/GroupVoIP.VLCKitIOS/build/Release-iphoneos/include .
cd ..
