package com.vispar.debateme;

import air.Vispar.*;
import android.os.Bundle;

public class AirConfActivity extends AppEntry {
	@Override
	public void onCreate(Bundle arg0) {
		System.out.println("test test");
		getActionBar().hide();
		super.onCreate(arg0);
	}
}
