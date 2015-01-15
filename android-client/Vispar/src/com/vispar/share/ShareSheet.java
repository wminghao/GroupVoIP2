package com.vispar.share;

import java.util.ArrayList;
import java.util.List;

import android.app.Fragment;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Parcelable;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.vispar.R;

public class ShareSheet {
	static public void share(final ViewGroup container, Fragment frag, View view, String msgToShare, boolean allowFacebook) {
		Intent intent = new Intent(Intent.ACTION_SEND);
  		 intent.setType("text/plain");
  		 List<Intent> targetedShareIntents = new ArrayList<Intent>();
		 
  		 final PackageManager pm = container.getContext().getPackageManager();
  		 final List<ResolveInfo> matches = pm.queryIntentActivities(intent, 0);
  		 for (final ResolveInfo info : matches) {
  			 String packageName = info.activityInfo.packageName;
  			 System.out.println("Package name: "+ packageName);
  			 Intent targetedShareIntent = new Intent(android.content.Intent.ACTION_SEND);
  			 
  			 if( allowFacebook ) {
  				if (packageName.equals("com.facebook.katana")){
					 targetedShareIntent.setType("text/plain");
		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
		  			 targetedShareIntent.setPackage(packageName);
		  			 targetedShareIntents.add(targetedShareIntent);
		  			 continue;
  				}
  			 }
  			 
  			 if (packageName.equals("com.facebook.orca")){
					 	targetedShareIntent.setType("text/plain");
					 	targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
					 	targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
 			 } else if (packageName.equals("com.twitter.android") || packageName.endsWith("twitter")) {
  				 targetedShareIntent.setType("text/plain");
		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.equals("com.viber.voip")) {
  				 targetedShareIntent.setType("text/plain");
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.equals("com.groupme.android")) {
  				 targetedShareIntent.setType("text/plain");
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.equals("kik.android")) {
  				 targetedShareIntent.setType("text/plain");
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
  				 targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.endsWith(".gm") || packageName.endsWith("gmail")){
  			 	 targetedShareIntent.setType("text/plain");
  				 targetedShareIntent.putExtra(Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
  				 targetedShareIntent.putExtra(Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.endsWith(".email") || packageName.endsWith(".mail")){
  				 targetedShareIntent.setType("text/plain");
  				 targetedShareIntent.putExtra(Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
  				 targetedShareIntent.putExtra(Intent.EXTRA_TEXT, msgToShare);
  			 } else if (packageName.endsWith(".mms") ){
  				 targetedShareIntent.setType("text/plain");
  				 //targetedShareIntent.putExtra(Intent.EXTRA_SUBJECT, getString(R.string.shareSubject));
  				 targetedShareIntent.putExtra(Intent.EXTRA_TEXT, msgToShare);
  			 } else {
  				 continue;
  			 }
  			 targetedShareIntent.setPackage(packageName);
  			 targetedShareIntents.add(targetedShareIntent);
  		 }
  		 //add clipboard
		 Intent clipboardIntent = new Intent(frag.getActivity(), ClipboardActivity.class);
		 clipboardIntent.setType("text/plain");
		 clipboardIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, frag.getString(R.string.share_subject));
		 clipboardIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
		 clipboardIntent.setPackage(".share.ClipboardActivity");
         targetedShareIntents.add(clipboardIntent);
  		 
  		 if (targetedShareIntents.size() >0) {
  			 Intent chooserIntent = Intent.createChooser(targetedShareIntents.remove(0), frag.getString(R.string.select_to_share));
  			 chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, targetedShareIntents.toArray(new Parcelable[]{}));
  			frag.startActivityForResult(chooserIntent, 0);
  		 } else {
  			 Toast toast = Toast.makeText(
  					 view.getContext(), 
  					 frag.getString(R.string.no_app_to_share), 
      	             Toast.LENGTH_LONG
  	             );
          	     toast.show();
  		 }		
	}
}
