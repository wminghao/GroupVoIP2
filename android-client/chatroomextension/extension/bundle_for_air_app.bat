./cleanup.bat
mkdir -p Android-ARM
unzip ../../chatroombridge/bin/chatroombridge.swc library.swf
cp library.swf Android-ARM
cp ~/ChatroomExtension.jar Android-ARM
cp -r ../res Android-ARM
cp  /Applications/adt-bundle-mac-x86_64-20140702/sdk/extras/android/support/v7/recyclerview/libs/android-support-v7-recyclerview.jar Android-ARM
cd Android-ARM
#combine android-support-v7-recyclerview.jar with ChatroomExtension.jar
jar -xf android-support-v7-recyclerview.jar
jar -uf ChatroomExtension.jar android
cd ..
/Applications/Adobe\ Flash\ Builder\ 4.6/sdks/4.6.0/bin/adt -package -target ane com.vispar.extension.ChatroomDialog.ane ./extension.xml -swc ../../chatroombridge/bin/chatroombridge.swc -platform Android-ARM -C ./Android-ARM .
#/Applications/Adobe\ Flash\ Builder\ 4.6/sdks/4.6.0/bin/adt -package -target ane com.vispar.extension.ChatroomDialog.ane ./extension.xml -swc ../../chatroombridge/bin/chatroombridge.swc -platform Android-ARM -platformoptions platform-options-android.xml -C ./Android-ARM .

