package com.vispar.settings;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.LoaderManager.LoaderCallbacks;
import android.content.CursorLoader;
import android.content.Intent;
import android.content.Loader;
import android.database.Cursor;
import android.net.Uri;
import android.os.AsyncTask;

import android.os.Build;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.EditorInfo;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

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
import com.vispar.mysessions.AirConfActivity;

/**
 * A login screen that offers login via email/password.
 */
public class LoginActivity extends Activity implements LoaderCallbacks<Cursor> {
	/**
	 * Keep track of the login task to ensure we can cancel it if requested.
	 */
	private UserLoginTask mAuthTask = null;

	//RESTful API for login request
	private static String LOGIN_URL = "/login";
	
	// UI references.
	private AutoCompleteTextView mEmailView;
	private EditText mPasswordView;
	private View mProgressView;
	private View mLoginFormView;	
	
	public static String USER_NAME_KEY = "UserName";
	public static String EXPIRATION_TS_KEY = "Expired";
	public static String TOKEN_KEY = "Token";
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);

		// Set up the login form.
		mEmailView = (AutoCompleteTextView) findViewById(R.id.email);
		populateAutoComplete();

		mPasswordView = (EditText) findViewById(R.id.password);
		mPasswordView
				.setOnEditorActionListener(new TextView.OnEditorActionListener() {
					@Override
					public boolean onEditorAction(TextView textView, int id,
							KeyEvent keyEvent) {
						if (id == R.id.login || id == EditorInfo.IME_NULL) {
							attemptLogin();
							return true;
						}
						return false;
					}
				});

		Button mEmailSignInButton = (Button) findViewById(R.id.email_sign_in_button);
		mEmailSignInButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				attemptLogin();
			}
		});

		mLoginFormView = findViewById(R.id.login_form);
		mProgressView = findViewById(R.id.login_progress);
		
		Button registerButton = (Button) findViewById(R.id.click_to_register_button_from_login);
		registerButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				Intent i = new Intent(LoginActivity.this, com.vispar.settings.RegisterActivity.class);
		        startActivityForResult(i, MainActivity.REQUEST_REGISTER);
			}
		});
		/*
		 * Forget password
		Button forgetPasswordButton = (Button) findViewById(R.id.click_to_forget_password_button_from_login);
		forgetPasswordButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				Intent i = new Intent(LoginActivity.this, com.vispar.settings.ForgetPasswordActivity.class);
		        finish();
		        startActivity(i);
			}
		});
		*/
		
	}

	private void populateAutoComplete() {
		getLoaderManager().initLoader(0, null, this);
	}

	/**
	 * Attempts to sign in or register the account specified by the login form.
	 * If there are form errors (invalid email, missing fields, etc.), the
	 * errors are presented and no actual login attempt is made.
	 */
	public void attemptLogin() {
		if (mAuthTask != null) {
			return;
		}

		// Reset errors.
		mEmailView.setError(null);
		mPasswordView.setError(null);

		// Store values at the time of the login attempt.
		String email = mEmailView.getText().toString();
		String password = mPasswordView.getText().toString();

		boolean cancel = false;
		View focusView = null;

		// Check for a valid password, if the user entered one.
		if (!TextUtils.isEmpty(password) && !isPasswordValid(password)) {
			mPasswordView.setError(getString(R.string.error_invalid_password));
			focusView = mPasswordView;
			cancel = true;
		}

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
			mAuthTask = new UserLoginTask(email, password);
			mAuthTask.execute((Void) null);
		}
	}

	private boolean isEmailValid(String email) {
		// TODO: Replace this with your own logic
		return email.contains("@");
	}

	private boolean isPasswordValid(String password) {
		// TODO: Replace this with your own logic
		return password.length() > 4;
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

			mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
			mLoginFormView.animate().setDuration(shortAnimTime)
					.alpha(show ? 0 : 1)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mLoginFormView.setVisibility(show ? View.GONE
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
			mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
		}
	}

	@Override
	public Loader<Cursor> onCreateLoader(int i, Bundle bundle) {
		return new CursorLoader(this,
				// Retrieve data rows for the device user's 'profile' contact.
				Uri.withAppendedPath(ContactsContract.Profile.CONTENT_URI,
						ContactsContract.Contacts.Data.CONTENT_DIRECTORY),
				ProfileQuery.PROJECTION,

				// Select only email addresses.
				ContactsContract.Contacts.Data.MIMETYPE + " = ?",
				new String[] { ContactsContract.CommonDataKinds.Email.CONTENT_ITEM_TYPE },

				// Show primary email addresses first. Note that there won't be
				// a primary email address if the user hasn't specified one.
				ContactsContract.Contacts.Data.IS_PRIMARY + " DESC");
	}

	@Override
	public void onLoadFinished(Loader<Cursor> cursorLoader, Cursor cursor) {
		List<String> emails = new ArrayList<String>();
		cursor.moveToFirst();
		while (!cursor.isAfterLast()) {
			emails.add(cursor.getString(ProfileQuery.ADDRESS));
			cursor.moveToNext();
		}

		addEmailsToAutoComplete(emails);
	}

	@Override
	public void onLoaderReset(Loader<Cursor> cursorLoader) {

	}

	private interface ProfileQuery {
		String[] PROJECTION = { ContactsContract.CommonDataKinds.Email.ADDRESS,
				ContactsContract.CommonDataKinds.Email.IS_PRIMARY, };

		int ADDRESS = 0;
		int IS_PRIMARY = 1;
	}

	private void addEmailsToAutoComplete(List<String> emailAddressCollection) {
		// Create adapter to tell the AutoCompleteTextView what to show in its
		// dropdown list.
		ArrayAdapter<String> adapter = new ArrayAdapter<String>(
				LoginActivity.this,
				android.R.layout.simple_dropdown_item_1line,
				emailAddressCollection);

		mEmailView.setAdapter(adapter);
	}

	/**
	 * Represents an asynchronous login/registration task used to authenticate
	 * the user.
	 */
	public class UserLoginTask extends AsyncTask<Void, Void, List<BasicNameValuePair>> {

		private final String mEmail;
		private final String mPassword;

		UserLoginTask(String email, String password) {
			mEmail = email;
			mPassword = password;
		}

		@Override
		protected List<BasicNameValuePair> doInBackground(Void... params) {
			List<BasicNameValuePair> list = new ArrayList<BasicNameValuePair>();
			try {
			    StringBuilder body = new StringBuilder();
			    DefaultHttpClient httpclient = new DefaultHttpClient(); // create new httpClient
			    HttpPost httpPost = new HttpPost(VisparApplication.WebServerDomainName +LOGIN_URL); // create new httpGet object
			    httpPost.addHeader("Content-type","application/x-www-form-urlencoded");
			    httpPost.addHeader("Accept","application/json");
			    
			    List <NameValuePair> nvps = new ArrayList <NameValuePair>();
			    nvps.add(new BasicNameValuePair("email", mEmail));
			    nvps.add(new BasicNameValuePair("password", mPassword));
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

			if (list != null) {
				Intent intent = new Intent();
				for (BasicNameValuePair element : list) {
					if( element.getName() == "name") {
						intent.putExtra(USER_NAME_KEY, element.getValue());
					} else if( element.getName() == "expired" ) {
						intent.putExtra(EXPIRATION_TS_KEY, Long.parseLong(element.getValue(), 10));
					} else if( element.getName() == "token" ) {
						intent.putExtra(TOKEN_KEY, element.getValue());
					}
				}
	            setResult(RESULT_OK, intent);
				finish();
			} else {
				mPasswordView.setError(getString(R.string.error_incorrect_info_login));
				mPasswordView.requestFocus();
			}
		}

		@Override
		protected void onCancelled() {
			mAuthTask = null;
			showProgress(false);
		}
	}

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        // Check which request we're responding to
        if (requestCode == MainActivity.REQUEST_REGISTER) {
            // Make sure the request was successful
            if (resultCode == RESULT_OK) {
            	Intent intent = new Intent();
                String userName = data.getStringExtra(LoginActivity.USER_NAME_KEY);
                String token = data.getStringExtra(LoginActivity.TOKEN_KEY);
                long expired = data.getLongExtra(LoginActivity.EXPIRATION_TS_KEY, 0);
				intent.putExtra(USER_NAME_KEY, userName);
				intent.putExtra(EXPIRATION_TS_KEY, expired);
				intent.putExtra(TOKEN_KEY, token);
				setResult(RESULT_OK, intent);
				finish();
            }
        }
    }
}
