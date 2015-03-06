package com.vispar.extension.ChatroomDialog;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class ChatroomDialogInitFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		ChatroomDialogExtensionContext adec=(ChatroomDialogExtensionContext)context;
		android.app.Activity activity=adec.getActivity();
		adec.activity=activity;
		return null;
	}
}