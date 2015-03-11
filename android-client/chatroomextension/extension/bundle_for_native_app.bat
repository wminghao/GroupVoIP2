./cleanup.bat
mkdir -p Android-ARM
unzip ../../chatroombridge/bin/chatroombridge.swc library.swf
cp library.swf Android-ARM
cp ~/ChatroomExtension.jar Android-ARM
cd Android-ARM
mkdir ChatroomExtensionTemp
cd ChatroomExtensionTemp
mv ../ChatroomExtension.jar .
jar -xvf ChatroomExtension.jar
rm ChatroomExtension.jar
rm com/vispar/R*.class
jar -cvf ChatroomExtension.jar *
mv ChatroomExtension.jar ..
cd ..
rm -rf ChatroomExtensionTemp
cd ..
/Applications/Adobe\ Flash\ Builder\ 4.6/sdks/4.6.0/bin/adt -package -target ane com.vispar.extension.ChatroomDialog.ane ./extension.xml -swc ../../chatroombridge/bin/chatroombridge.swc -platform Android-ARM -C ./Android-ARM .
