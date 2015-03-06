package com.vispar.extension.ChatroomDialog;


import java.util.Map;

import com.adobe.fre.FREFunction;

public class ChatroomDialogExtensionContext extends com.adobe.fre.FREContext{
	public android.app.Activity activity;
	public Map<String, FREFunction> getFunctions()
	 {
		Map<String,FREFunction> functionMap=new java.util.HashMap<String,FREFunction>();
		functionMap.put("ffiShowChatroom",new ChatroomDialogShowDialogMessageFunction());
		functionMap.put("ffiInit",new ChatroomDialogInitFunction());

		return functionMap;
	}

	@Override
	public void dispose() {
		activity = null;
	}
}