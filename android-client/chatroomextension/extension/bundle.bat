rm -rf Android-ARM/*
rm -f com.vispar.extension.ChatroomDialog.ane library.swf
mkdir -p Android-ARM
unzip ../../chatroombridge/bin/chatroombridge.swc library.swf
cp library.swf Android-ARM
cp ~/ChatroomExtension.jar Android-ARM
cp ../libs/android-support-v7-recyclerview.jar Android-ARM
cp -r ../res Android-ARM
/Applications/Adobe\ Flash\ Builder\ 4.6/sdks/4.6.0/bin/adt -package -target ane com.vispar.extension.ChatroomDialog.ane ./extension.xml -swc ../../chatroombridge/bin/chatroombridge.swc -platform Android-ARM -platformoptions platform-options-android.xml -C ./Android-ARM .