rm -rf airconf
./apktool d ~/airconf.apk
echo "got airconf"
#don't copy resources directly, be very careful with resources
#cp -r airconf/res/* ~/GroupVoIP2/android-client/Vispar/res/
cp -r airconf/assets/airconf.swf ~/GroupVoIP2/android-client/Vispar/assets/
cp -r airconf/lib/armeabi-v7a/*.so ~/GroupVoIP2/android-client/Vispar/libs/armeabi-v7a/
echo "done"