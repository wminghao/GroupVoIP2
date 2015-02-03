package com.vispar.mysessions;

import java.util.List;

import air.Vispar.*;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.net.Uri;

public class AirConfActivity extends AppEntry {
	@Override
	public void onCreate(Bundle arg0) {
		this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		getActionBar().hide();
		Uri data = getIntent().getData();
		if( data != null ) {
			List<String> params = data.getPathSegments();
			if( params != null && (params.size() >= 4) ) {
				String type = data.getHost();
				String room = params.get(1);
				String user = params.get(2);
				String sessionId = params.get(3);
				System.out.println("AirConfActivity launched. type=" + type);
				System.out.println("AirConfActivity launched. room=" + room);
				System.out.println("AirConfActivity launched. user=" + user);
				System.out.println("AirConfActivity launched. sessionId=" + sessionId);				
			}
		}
		super.onCreate(arg0);
	}
	
	@Override
	public void onStop() {
		System.out.println("AirConfActivity exited.");		
		super.onStop();
	}
}
