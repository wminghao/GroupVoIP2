package com.vispar.settings;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

import com.vispar.R;
import com.vispar.VisparApplication;

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

public class RegisterActivity extends Activity implements LoaderCallbacks<Cursor>  {
	/**
	 * Keep track of the register task to ensure we can cancel it if requested.
	 */
	private UserRegisterTask mAuthTask = null;

	//RESTful API for register request
	private static String REGISTER_URL = "/signup";
	
	// UI references.
	private AutoCompleteTextView mEmailView;
	private EditText mPasswordView;
	private EditText mUserNameView;
	private View mProgressView;
	private View mRegisterFormView;	
	
	public static String USER_NAME_KEY = "UserName";
	public static String EXPIRATION_TS_KEY = "Expired";
	public static String TOKEN_KEY = "Token";
	
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_register);

		// Set up the register form.
		mEmailView = (AutoCompleteTextView) findViewById(R.id.email_register);
		populateAutoComplete();

		mPasswordView = (EditText) findViewById(R.id.password_register);
		mPasswordView
				.setOnEditorActionListener(new TextView.OnEditorActionListener() {
					@Override
					public boolean onEditorAction(TextView textView, int id,
							KeyEvent keyEvent) {
						if (id == R.id.register || id == EditorInfo.IME_NULL) {
							attemptRegister();
							return true;
						}
						return false;
					}
				});

		mUserNameView = (EditText) findViewById(R.id.username_register);
		mUserNameView
				.setOnEditorActionListener(new TextView.OnEditorActionListener() {
					@Override
					public boolean onEditorAction(TextView textView, int id,
							KeyEvent keyEvent) {
						if (id == R.id.register || id == EditorInfo.IME_NULL) {
							attemptRegister();
							return true;
						}
						return false;
					}
				});

		Button mEmailRegisterButton = (Button) findViewById(R.id.email_register_button);
		mEmailRegisterButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				attemptRegister();
			}
		});

		mRegisterFormView = findViewById(R.id.register_form);
		mProgressView = findViewById(R.id.register_progress);
		

		Button loginButton = (Button) findViewById(R.id.click_to_login_button_from_register);
		loginButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				Intent i = new Intent(RegisterActivity.this, com.vispar.settings.LoginActivity.class);
		        finish();
		        startActivity(i);
			}
		});
		Button forgetPasswordButton = (Button) findViewById(R.id.click_to_forget_password_button_from_register);
		forgetPasswordButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View view) {
				Intent i = new Intent(RegisterActivity.this, com.vispar.settings.ForgetPasswordActivity.class);
		        finish();
		        startActivity(i);
			}
		});
	}

	private void populateAutoComplete() {
		getLoaderManager().initLoader(0, null, this);
	}

	/**
	 * Attempts to register the account specified by the register form.
	 * If there are form errors (invalid email, missing fields, etc.), the
	 * errors are presented and no actual register attempt is made.
	 */
	public void attemptRegister() {
		if (mAuthTask != null) {
			return;
		}

		// Reset errors.
		mEmailView.setError(null);
		mPasswordView.setError(null);
		mUserNameView.setError(null);

		// Store values at the time of the register attempt.
		String email = mEmailView.getText().toString();
		String password = mPasswordView.getText().toString();
		String userName = mUserNameView.getText().toString();

		boolean cancel = false;
		View focusView = null;

		// Check for a valid password, if the user entered one.
		if (!TextUtils.isEmpty(password) && !isPasswordValid(password) ) {
			mPasswordView.setError(getString(R.string.error_invalid_password));
			focusView = mPasswordView;
			cancel = true;
		}
		
		if (!TextUtils.isEmpty(userName) && !isUserNameValid(userName) ) {
			mUserNameView.setError(getString(R.string.error_invalid_username));
			focusView = mUserNameView;
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
			// There was an error; don't attempt register and focus the first
			// form field with an error.
			focusView.requestFocus();
		} else {
			// Show a progress spinner, and kick off a background task to
			// perform the user register attempt.
			showProgress(true);
			mAuthTask = new UserRegisterTask(userName, email, password);
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

	public static boolean isUserNameValid(String userName) {
		Pattern pattern = Pattern.compile("\\s"); //any other special characters.
		Matcher matcher = pattern.matcher(userName);
		boolean foundSpecialCharacters = matcher.find();
		return userName.length() >= 4 && !foundSpecialCharacters;
	}
	/**
	 * Shows the progress UI and hides the register form.
	 */
	@TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
	public void showProgress(final boolean show) {
		// On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
		// for very easy animations. If available, use these APIs to fade-in
		// the progress spinner.
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
			int shortAnimTime = getResources().getInteger(
					android.R.integer.config_shortAnimTime);

			mRegisterFormView.setVisibility(show ? View.GONE : View.VISIBLE);
			mRegisterFormView.animate().setDuration(shortAnimTime)
					.alpha(show ? 0 : 1)
					.setListener(new AnimatorListenerAdapter() {
						@Override
						public void onAnimationEnd(Animator animation) {
							mRegisterFormView.setVisibility(show ? View.GONE
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
			mRegisterFormView.setVisibility(show ? View.GONE : View.VISIBLE);
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
				RegisterActivity.this,
				android.R.layout.simple_dropdown_item_1line,
				emailAddressCollection);

		mEmailView.setAdapter(adapter);
	}

	/**
	 * Represents an asynchronous registration task used to authenticate
	 * the user.
	 */
	public class UserRegisterTask extends AsyncTask<Void, Void, List<BasicNameValuePair>> {
		
		private final String mUserName;
		private final String mEmail;
		private final String mPassword;

		UserRegisterTask(String userName, String email, String password) {
			mUserName = userName;
			mEmail = email;
			mPassword = password;
		}

		@Override
		protected List<BasicNameValuePair> doInBackground(Void... params) {
			List<BasicNameValuePair> list = new ArrayList<BasicNameValuePair>();
			try {
			    StringBuilder body = new StringBuilder();
			    DefaultHttpClient httpclient = new DefaultHttpClient(); // create new httpClient
			    HttpPost httpPost = new HttpPost(VisparApplication.WebServerDomainName +REGISTER_URL); // create new httpGet object
			    httpPost.addHeader("Content-type","application/x-www-form-urlencoded");
			    httpPost.addHeader("Accept","application/json");
			    
			    List <NameValuePair> nvps = new ArrayList <NameValuePair>();
			    nvps.add(new BasicNameValuePair("name", mUserName));
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
				mPasswordView.setError(getString(R.string.error_incorrect_info_register));
				mPasswordView.requestFocus();
			}
		}

		@Override
		protected void onCancelled() {
			mAuthTask = null;
			showProgress(false);
		}
	}
}
