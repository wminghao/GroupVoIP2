package com.vispar.debateme.share;

import com.vispar.debateme.R;

import android.app.Activity;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

public class ClipboardActivity extends Activity {

    @SuppressWarnings("deprecation")
	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.getActionBar().hide();

    	// Copy EditCopy text to the ClipBoard
    	ClipboardManager ClipMan = (ClipboardManager) this.getSystemService(Context.CLIPBOARD_SERVICE);
    	Intent intent = getIntent();
    	String msgToShare = intent.getStringExtra(android.content.Intent.EXTRA_TEXT);
    	ClipMan.setText(msgToShare);
    	Toast.makeText(this.getApplicationContext(), getString(R.string.clipboard_share), Toast.LENGTH_SHORT).show();
    	
    	this.finish();
    }
}
