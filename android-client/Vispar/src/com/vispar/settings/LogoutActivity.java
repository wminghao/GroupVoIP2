package com.vispar.settings;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.StatusLine;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import com.vispar.R;
import com.vispar.VisparApplication;
import com.vispar.settings.RegisterActivity.UserRegisterTask;

public class LogoutActivity extends Activity {
	/**
	 * Keep track of the register task to ensure we can cancel it if requested.
	 */
	private LogoutTask mLogoutTask = null;
	//RESTful API for logout request
	private static String LOGOUT_URL = "/logout";
	private View mProgressView;
	
	@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.getActionBar().hide();
		setContentView(R.layout.activity_logout);

		mProgressView = findViewById(R.id.logout_progress);
		
        Bundle extras = getIntent().getExtras();
        if(extras != null) {
        	String userName= extras.getString(Intent.EXTRA_TEXT);
            mLogoutTask = new LogoutTask(userName);
            mLogoutTask.execute((Void) null);
			showProgress(true);
        }
    }
    /**
	 * Represents an asynchronous registration task used to authenticate
	 * the user.
	 */
	public class LogoutTask extends AsyncTask<Void, Void, Boolean> {
		
		private final String mUserName;

		LogoutTask(String userName) {
			mUserName = userName;
		}

		@Override
		protected Boolean doInBackground(Void... params) {
			boolean isSuccess = false;
			try {
			    StringBuilder body = new StringBuilder();
			    DefaultHttpClient httpclient = new DefaultHttpClient(); // create new httpClient
			    HttpPost httpPost = new HttpPost(VisparApplication.WebServerDomainName +LOGOUT_URL); // create new httpGet object
			    httpPost.addHeader("Content-type","application/x-www-form-urlencoded");
			    httpPost.addHeader("Accept","application/json");
			    
			    List <NameValuePair> nvps = new ArrayList <NameValuePair>();
			    nvps.add(new BasicNameValuePair("name", mUserName));
			    httpPost.setEntity(new UrlEncodedFormEntity(nvps));
			    
			    HttpResponse response = httpclient.execute(httpPost); // execute httpPost
			    StatusLine statusLine = response.getStatusLine();
			    int statusCode = statusLine.getStatusCode();
		        if (statusCode == HttpStatus.SC_OK) {
		        	// System.out.println(statusLine);
		            //body.append(statusLine + "\n");
		            HttpEntity e = response.getEntity();
		            String entity = EntityUtils.toString(e);
		            body.append(entity);
				    String bodyStr = body.toString(); // return the String
				    isSuccess = true;
		        } else {
		            body.append(statusLine + "\n");
		            // System.out.println(statusLine);
		        }
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
			}
			return isSuccess;
		}

		@Override
		protected void onPostExecute(final Boolean isSuccess) {	
			showProgress(false);		
			Intent intent = new Intent();
			if (isSuccess) {
	            setResult(RESULT_OK, intent);
				finish();
		    	Toast.makeText(LogoutActivity.this.getApplicationContext(), getString(R.string.logout_success), Toast.LENGTH_SHORT).show();
			} else {
	            setResult(RESULT_CANCELED, intent);
				finish();
		    	Toast.makeText(LogoutActivity.this.getApplicationContext(), getString(R.string.logout_fail), Toast.LENGTH_SHORT).show();
			}
		}

		@Override
		protected void onCancelled() {
			showProgress(false);
		}
	}


	/**
	 * Shows the progress UI and hides the login form.
	 */
	@TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
	public void showProgress(final boolean show) {
		// On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
		// for very easy animations. If available, use these APIs to fade-in
		// the progress spinner.
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
			int shortAnimTime = getResources().getInteger(
					android.R.integer.config_shortAnimTime);

			mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
			mProgressView.animate().setDuration(shortAnimTime)
					.alpha(show ? 1 : 0)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mProgressView.setVisibility(show ? View.VISIBLE
									: View.GONE);
						}
					});
		} else {
			// The ViewPropertyAnimator APIs are not available, so simply show
			// and hide the relevant UI components.
			mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
		}
	}

}
