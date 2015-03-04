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

import com.vispar.MainActivity;
import com.vispar.R;
import com.vispar.VisparApplication;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AutoCompleteTextView;
import android.widget.Button;

public class ForgetPasswordActivity extends Activity {
	/**
	 * Keep track of the login task to ensure we can cancel it if requested.
	 */
	private UserForgetPasswordTask mAuthTask = null;
	
	//RESTful API for forgetpassword request
	private static String FORGETPASSWORD_URL = "/forgetpassword";
	
	// UI references.
	private AutoCompleteTextView mEmailView;
	private View mProgressView;
	private View mForgetPasswordFormView;	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_forget_password);
		mEmailView = (AutoCompleteTextView) findViewById(R.id.forgetpassword_email);

		Button mEmailForgetPasswordButton = (Button) findViewById(R.id.forgetpassword_button);
		mEmailForgetPasswordButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				attemptResetPassword();
			}
		});

		mForgetPasswordFormView = findViewById(R.id.forgetpassword_form);
		mProgressView = findViewById(R.id.forgetpassword_progress);
		
		Button loginButton = (Button) findViewById(R.id.click_to_login_button_from_forgetpassword);
		loginButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
				Intent i = new Intent(ForgetPasswordActivity.this, com.vispar.settings.RegisterActivity.class);
		        startActivityForResult(i, MainActivity.REQUEST_LOGIN);
			}
		});
		Button registerButton = (Button) findViewById(R.id.click_to_register_button_from_forgetpassword);
		registerButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				finish();
				Intent i = new Intent(ForgetPasswordActivity.this, com.vispar.settings.RegisterActivity.class);
		        startActivityForResult(i, MainActivity.REQUEST_REGISTER);
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.forget_password, menu);
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

	private boolean isEmailValid(String email) {
		// TODO: Replace this with your own logic
		return email.contains("@");
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

			mForgetPasswordFormView.setVisibility(show ? View.GONE : View.VISIBLE);
			mForgetPasswordFormView.animate().setDuration(shortAnimTime)
					.alpha(show ? 0 : 1)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mForgetPasswordFormView.setVisibility(show ? View.GONE
									: View.VISIBLE);
						}
					});

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
			mForgetPasswordFormView.setVisibility(show ? View.GONE : View.VISIBLE);
		}
	}
	

	/**
	 * Attempts to sign in or register the account specified by the login form.
	 * If there are form errors (invalid email, missing fields, etc.), the
	 * errors are presented and no actual login attempt is made.
	 */
	public void attemptResetPassword() {
		if (mAuthTask != null) {
			return;
		}

		// Reset errors.
		mEmailView.setError(null);

		// Store values at the time of the login attempt.
		String email = mEmailView.getText().toString();

		boolean cancel = false;
		View focusView = null;

		// Check for a valid email address.
		if (TextUtils.isEmpty(email)) {
			mEmailView.setError(getString(R.string.error_field_required));
			focusView = mEmailView;
			cancel = true;
		} else if (!isEmailValid(email)) {
			mEmailView.setError(getString(R.string.error_invalid_email));
			focusView = mEmailView;
			cancel = true;
		}

		if (cancel) {
			// There was an error; don't attempt login and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user login attempt.
			showProgress(true);
			mAuthTask = new UserForgetPasswordTask(email);
			mAuthTask.execute((Void) null);
		}
	}
	/**
	 * Represents an asynchronous login/registration task used to authenticate
	 * the user.
	 */
	public class UserForgetPasswordTask extends AsyncTask<Void, Void, List<BasicNameValuePair>> {

		private final String mEmail;

		UserForgetPasswordTask(String email) {
			mEmail = email;
		}

		@Override
		protected List<BasicNameValuePair> doInBackground(Void... params) {
			List<BasicNameValuePair> list = new ArrayList<BasicNameValuePair>();
			try {
			    StringBuilder body = new StringBuilder();
			    DefaultHttpClient httpclient = new DefaultHttpClient(); // create new httpClient
			    HttpPost httpPost = new HttpPost(VisparApplication.WebServerDomainName +FORGETPASSWORD_URL); // create new httpGet object
			    httpPost.addHeader("Content-type","application/x-www-form-urlencoded");
			    httpPost.addHeader("Accept","application/json");
			    
			    List <NameValuePair> nvps = new ArrayList <NameValuePair>();
			    nvps.add(new BasicNameValuePair("email", mEmail));
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
				    // Instantiate a JSON object from the request response
				    JSONObject jsonObject = new JSONObject(bodyStr);
				    list.add(new BasicNameValuePair("name", jsonObject.getString("name")));
				    list.add(new BasicNameValuePair("expired", Long.toString(jsonObject.getLong("expired"))));
				    list.add(new BasicNameValuePair("token", jsonObject.getString("token")));
				    
				    /* Return value as following
				     * {
 						"id": "54e38b0b623d7f700732732b",
 						"token": "1231312312312312312123123",
 						"name": "Guangda Zhang”
 						“expired”: 12:31:2025
					   }
				     */
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
			return list;
		}

		@Override
		protected void onPostExecute(final List<BasicNameValuePair> list) {
			mAuthTask = null;
			showProgress(false);

			if (list != null && list.size() > 0) {
				Intent intent = new Intent();
	            setResult(RESULT_OK, intent);
				finish();
			} else {
				mEmailView.setError(getString(R.string.error_incorrect_info_forgetpassowrd));
				mEmailView.requestFocus();
			}
		}

		@Override
		protected void onCancelled() {
			mAuthTask = null;
			showProgress(false);
		}
	}
}
