package com.vispar.schedule;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import com.vispar.R;
import com.vispar.VisparApplication;

import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;

public class ViewEventActivity extends Activity {
	TextView organizer;
	TextView eventTitle;
	TextView eventDescription;
	TextView eventStartTime;
	TextView eventEndTime;
	CheckBox isPublic;
	AsyncTask<String, Void, Boolean> loadEvents;
	String urlForViewEvents = "http://"+VisparApplication.WebServerUrl+":"+VisparApplication.WebServerPort+"/viewevent/";
	
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    	View inflatedView = View.inflate(this, R.layout.activity_event_details, null);
    	setContentView(inflatedView);
    	organizer = (TextView) inflatedView.findViewById(R.id.organizer);
    	eventTitle = (TextView) inflatedView.findViewById(R.id.eventTitle);
    	eventDescription = (TextView) inflatedView.findViewById(R.id.eventDescription);
    	eventStartTime = (TextView) inflatedView.findViewById(R.id.eventStartTime);
    	eventEndTime = (TextView) inflatedView.findViewById(R.id.eventEndTime);
    	isPublic = (CheckBox) inflatedView.findViewById(R.id.isPublic);
    	urlForViewEvents += "1"; //TODO organizer Id
    	loadEvents = new JSONAsyncTask().execute(urlForViewEvents);
    }
    class JSONAsyncTask extends AsyncTask<String, Void, Boolean> {
    	String oid;
    	String et;
    	String es;
    	String ee;
    	String ed;
    	boolean pc;
    	@Override
    	protected void onPreExecute() {
    	    super.onPreExecute();
    	}

    	@Override
    	protected Boolean doInBackground(String... urls) {
    	    try {
    	        //------------------>>
    	        HttpGet httppost = new HttpGet(urls[0]);
    	        HttpClient httpclient = new DefaultHttpClient();
    	        HttpResponse response = httpclient.execute(httppost);

    	        // StatusLine stat = response.getStatusLine();
    	        int status = response.getStatusLine().getStatusCode();

    	        if (status == 200) {
    	            HttpEntity entity = response.getEntity();
    	            String data = EntityUtils.toString(entity);

    	            JSONObject jsonObj = new JSONObject(data);
    	            oid =jsonObj.getString("OrganizerId");
    	            et =jsonObj.getString("EventTitle");
    	            ed =jsonObj.getString("EventDescription");
    	            es =jsonObj.getString("EventStartTime");
    	            ee =jsonObj.getString("EventEndTime");
    	            pc =jsonObj.getInt("Privacy") == 1;

    	            return true;
    	        }
    	    } catch (IOException e) {
    	        e.printStackTrace();
    	    } catch (JSONException e) {
    	        e.printStackTrace();
    	    }
    	    return false;
    	}

    	protected void onPostExecute(Boolean result) {
	        organizer.setText("Howard Wang"); //TODO
	        eventTitle.setText(et);
	        eventDescription.setText(ed);
	        eventStartTime.setText(es.replace('T', ' ').replaceAll(".000Z", ""));
	        eventEndTime.setText(ee.replace('T', ' ').replaceAll(".000Z", ""));
	        isPublic.setChecked(pc);
    	}
    }
}
