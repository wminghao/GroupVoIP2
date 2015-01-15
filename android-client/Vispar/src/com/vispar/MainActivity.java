package com.vispar;

import java.util.Locale;

import com.vispar.mysessions.AirConfActivity;
import com.vispar.R;
import com.vispar.share.ShareSheet;
import com.vispar.schedule.StartEventActivity;
import com.vispar.schedule.ViewEventActivity;

import android.app.Activity;
import android.app.ActionBar;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.support.v13.app.FragmentPagerAdapter;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

public class MainActivity extends Activity implements ActionBar.TabListener {
    
    /**
     * The {@link android.support.v4.view.PagerAdapter} that will provide
     * fragments for each of the sections. We use a
     * {@link FragmentPagerAdapter} derivative, which will keep every
     * loaded fragment in memory. If this becomes too memory intensive, it
     * may be best to switch to a
     * {@link android.support.v13.app.FragmentStatePagerAdapter}.
     */
    SectionsPagerAdapter mSectionsPagerAdapter;

    /**
     * The {@link ViewPager} that will host the section contents.
     */
    ViewPager mViewPager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Set up the action bar.
        final ActionBar actionBar = getActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);

        // Create the adapter that will return a fragment for each of the three
        // primary sections of the activity.
        mSectionsPagerAdapter = new SectionsPagerAdapter(getFragmentManager());

        // Set up the ViewPager with the sections adapter.
        mViewPager = (ViewPager) findViewById(R.id.pager);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        // When swiping between different sections, select the corresponding
        // tab. We can also use ActionBar.Tab#select() to do this if we have
        // a reference to the Tab.
        mViewPager.setOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {
            @Override
            public void onPageSelected(int position) {
                actionBar.setSelectedNavigationItem(position);
            }
        });

        // For each of the sections in the app, add a tab to the action bar.
        for (int i = 0; i < mSectionsPagerAdapter.getCount(); i++) {
            // Create a tab with text corresponding to the page title defined by
            // the adapter. Also specify this Activity object, which implements
            // the TabListener interface, as the callback (listener) for when
            // this tab is selected.
            actionBar.addTab(
                    actionBar.newTab()
                            .setText(mSectionsPagerAdapter.getPageTitle(i))
                            .setTabListener(this));
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

    @Override
    public void onTabSelected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
        // When the given tab is selected, switch to the corresponding page in
        // the ViewPager.
        mViewPager.setCurrentItem(tab.getPosition());
    }

    @Override
    public void onTabUnselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    @Override
    public void onTabReselected(ActionBar.Tab tab, FragmentTransaction fragmentTransaction) {
    }

    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            // getItem is called to instantiate the fragment for the given page.
            // Return a PlaceholderFragment (defined as a static inner class below).
            return PlaceholderFragment.newInstance(position + 1);
        }

        @Override
        public int getCount() {
            // Show 3 total pages.
            return 3; //4 by adding follow
        }

        @Override
        public CharSequence getPageTitle(int position) {
            Locale l = Locale.getDefault();
            switch (position) {
                case 0:
                    return getString(R.string.Explore).toUpperCase(l);
                case 1:
                    return getString(R.string.MySessions).toUpperCase(l);
                case 2:
                    return getString(R.string.Schedule).toUpperCase(l);
                    /*
                case 3:
                    return getString(R.string.Follow).toUpperCase(l);
                    */
            }
            return null;
        }
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

		Button inviteFriends = null;
        Button joinRoom = null;
        Button myVideos = null;

		Button inviteEvent = null;
        Button viewEvent = null;
        Button startEvent = null;
        
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, final ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = null;
            ///////////////////////////////////////
            //for My sessions, show 3 buttons
            ///////////////////////////////////////
            int selection = this.getArguments().getInt(ARG_SECTION_NUMBER);
            if(  selection == 2 ) {
            	rootView = inflater.inflate(R.layout.fragment_main, container, false);
            	inviteFriends = (Button) rootView.findViewById(R.id.Invite);
                joinRoom = (Button) rootView.findViewById(R.id.Room);
                myVideos = (Button) rootView.findViewById(R.id.MyVideo);
                
                inviteFriends.setOnClickListener( new View.OnClickListener() {
                	public void onClick(View v) {
    	           		 String msgToShare = getString(R.string.invite_session_message) + " http://www.vispar.com/rooms/howard"; //TODO
    	           		 ShareSheet.share(container, PlaceholderFragment.this, v, msgToShare, false);
                    }
                });    
                joinRoom.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        Intent intent = new Intent(getActivity(), AirConfActivity.class);
                        String url = "vispar.player://live/rooms/howard/now"; //TODO
                        Uri data = Uri.parse(url);
                        intent.setData(data);
                        startActivity(intent);
                    }
                });  
                myVideos.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                    	//TODO an activity to list all archived videos
                        Intent intent = new Intent(getActivity(), AirConfActivity.class);
                        String url = "vispar.player://vod/rooms/howard/1234567890";//TODO archive ID
                        Uri data = Uri.parse(url);
                        intent.setData(data);
                        startActivity(intent);
                    }
                });
            } else if(  selection == 3) {
            	rootView = inflater.inflate(R.layout.fragment_schedule, container, false);

            	viewEvent = (Button) rootView.findViewById(R.id.ViewEvent);
            	viewEvent.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        Intent intent = new Intent(getActivity(), ViewEventActivity.class);
                        String url = ""; //TODO
                        Uri data = Uri.parse(url);
                        intent.setData(data);
                        startActivity(intent);
                    }
                });  
            	startEvent = (Button) rootView.findViewById(R.id.StartEvent);
            	startEvent.setOnClickListener( new View.OnClickListener() {
                	public void onClick(View v) {
                		Intent intent = new Intent(getActivity(), StartEventActivity.class);
                        String url = ""; //TODO
                        Uri data = Uri.parse(url);
                        intent.setData(data);
                        startActivity(intent);
                    }
                });
            	inviteEvent = (Button) rootView.findViewById(R.id.InviteEvent);
            	inviteEvent.setOnClickListener( new View.OnClickListener() {
                	public void onClick(View v) {
    	           		 String msgToShare = getString(R.string.invite_event_message) + 
    	           				 " http://"+VisparApplication.WebServerUrl+":"+VisparApplication.WebServerPort+"/viewhtmlevent/1"; //TODO
    	           		 ShareSheet.share(container, PlaceholderFragment.this, v, msgToShare, true);
                    }
                });
            } else if(  selection == 1) {
            	rootView = inflater.inflate(R.layout.fragment_explore, container, false);
            } else {
            	rootView = inflater.inflate(R.layout.fragment_follow, container, false);
            }
            return rootView;
        }
    }

	@Override
	public void onStop() {
		System.out.println("MainActivity exited.");	
		super.onStop();
	}
}
