package com.vispar.extension.ChatroomDialog;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class ChatroomDialogShowDialogMessageFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		ChatroomDialogExtensionContext adec=(ChatroomDialogExtensionContext)context;
		try
		{
			String userName = args[0].getAsString();
			android.util.Log.e("AIR_AndroidDialog", "username="+userName);
			ChatroomDialog chatroomDialog = new ChatroomDialog(adec.activity, userName); 
			chatroomDialog.showDialog();
		}
		catch(Exception e)
		{
			android.util.Log.e("AIR_AndroidDialog",e.getMessage());
		}
		return null;
	}

}