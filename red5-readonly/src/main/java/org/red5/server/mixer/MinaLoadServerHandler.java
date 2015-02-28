package org.red5.server.mixer;

import java.util.Date;
import java.util.List;

import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MinaLoadServerHandler extends IoHandlerAdapter {

    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    @Override
    public void exceptionCaught( IoSession session, Throwable cause ) throws Exception
    {
        cause.printStackTrace();
    }
    @SuppressWarnings("deprecation")
	@Override
    public void messageReceived( IoSession session, Object message ) throws Exception
    {
        String str = message.toString();
        String ret = null;
        if(str.contains("GET / HTTP/")) {
        	ret = "HTTP/1.0 200 OK\r\n\r\n";
        	//print json result here 

        	List<GroupMixer.StatsObject> list = GroupMixer.getInstance().getStats();
        	JSONArray roomsArray = new JSONArray();
        	for (GroupMixer.StatsObject element : list) {
        		JSONObject obj = new JSONObject();
        		obj.put("owner", element.owner_);
        		obj.put("numofspeakers", element.numOfSpeakers_);
        		obj.put("numofviewers", element.numOfVieweres_);
        		roomsArray.add(obj);
        	}
        	JSONObject finalJson = new JSONObject();
        	finalJson.put("rooms", roomsArray);
        	finalJson.put("cpu", 0);
        	finalJson.put("memory", 400);	
        	ret += finalJson.toJSONString();
        } else {
        	ret = "HTTP/1.0 404 Not Found";
        }
    	session.write( ret );
        session.close();
    }
    @Override
    public void sessionIdle( IoSession session, IdleStatus status ) throws Exception
    {
    	log.info( "IDLE " + session.getIdleCount( status ));
    }
}
