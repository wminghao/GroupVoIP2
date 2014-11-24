package com.vispar.debateme;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
//import android.app.ActionBar;
import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.Toast;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Parcelable;

public class MainActivity extends Activity {

    protected static final String EXTRA_MESSAGE = "extra";
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

		Button inviteFriends = null;
        Button joinRoom = null;
        Button myVideos = null;
        
        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, final ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);

            inviteFriends = (Button) rootView.findViewById(R.id.Invite);
            joinRoom = (Button) rootView.findViewById(R.id.Room);
            myVideos = (Button) rootView.findViewById(R.id.MyVideo);
            
            inviteFriends.setOnClickListener( new View.OnClickListener() {
            	public void onClick(View v) {
	           		 String msgToShare = "Join my discussion by clicking here: http://debate.me/rooms/howard";
	           		 Intent intent = new Intent(Intent.ACTION_SEND);
	           		 intent.setType("text/plain");
	           		 List<Intent> targetedShareIntents = new ArrayList<Intent>();
           		 
	           		 final PackageManager pm = container.getContext().getPackageManager();
	           		 final List<ResolveInfo> matches = pm.queryIntentActivities(intent, 0);
	           		 for (final ResolveInfo info : matches) {
	           			 String packageName = info.activityInfo.packageName;
	           			 System.out.println("Package name: "+ packageName);
	           			 Intent targetedShareIntent = new Intent(android.content.Intent.ACTION_SEND);
	       				 if (packageName.equals("com.facebook.katana")){
	       					 targetedShareIntent.setType("text/plain");
	       		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, getString(R.string.share_subject));
	       		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
	           			 } else if (packageName.equals("com.twitter.android") || packageName.endsWith("twitter")) {
	           				 targetedShareIntent.setType("text/plain");
	       		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, getString(R.string.share_subject));
	       		             targetedShareIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
	           			 }
	           			 else if (packageName.endsWith(".gm") || packageName.endsWith("gmail")){
	           			 	 targetedShareIntent.setType("text/plain");
	           				 targetedShareIntent.putExtra(Intent.EXTRA_SUBJECT, getString(R.string.share_subject));
	           				 targetedShareIntent.putExtra(Intent.EXTRA_TEXT, msgToShare);
	           			 } else if (packageName.endsWith(".email") || packageName.endsWith(".mail")){
	           				 targetedShareIntent.setType("text/plain");
	           				 targetedShareIntent.putExtra(Intent.EXTRA_SUBJECT, getString(R.string.share_subject));
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
           			 Intent clipboardIntent = new Intent(android.content.Intent.ACTION_SEND);
           			 clipboardIntent.setType("text/plain");
           			 clipboardIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, getString(R.string.share_subject));
           			 clipboardIntent.putExtra(android.content.Intent.EXTRA_TEXT, msgToShare);
           			 clipboardIntent.setPackage(".ClipboardActivity");
                     targetedShareIntents.add(clipboardIntent);
	           		 
	           		 if (targetedShareIntents.size() >0) {
	           			 Intent chooserIntent = Intent.createChooser(targetedShareIntents.remove(0), getString(R.string.select_to_share));
	           			 chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, targetedShareIntents.toArray(new Parcelable[]{}));
	           			 startActivityForResult(chooserIntent, 0);
	           		 } else {
	           			 Toast toast = Toast.makeText(
	           					 v.getContext(), 
	               	             getString(R.string.no_app_to_share), 
	               	             Toast.LENGTH_LONG
	           	             );
	                   	     toast.show();
	           		 }
                }
            });    
            joinRoom.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    Intent intent = new Intent(getActivity(), AirConfActivity.class);
                    String message = "rooms/howard"; //TODO
                    intent.putExtra(EXTRA_MESSAGE, message);
                    startActivity(intent);
                }
            });  
            myVideos.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    // Copy the link for now
                }
            });  
            return rootView;
        }
    }
}
