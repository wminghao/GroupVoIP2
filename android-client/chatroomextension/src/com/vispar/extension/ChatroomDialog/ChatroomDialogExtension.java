package com.vispar.extension.ChatroomDialog;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class ChatroomDialogExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new ChatroomDialogExtensionContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
