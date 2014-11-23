package com.vispar.debateme;

import air.Vispar.*;
import android.content.pm.ActivityInfo;
import android.os.Bundle;

public class AirConfActivity extends AppEntry {
	@Override
	public void onCreate(Bundle arg0) {
		this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		System.out.println("test test");
		getActionBar().hide();
		super.onCreate(arg0);
	}
}
