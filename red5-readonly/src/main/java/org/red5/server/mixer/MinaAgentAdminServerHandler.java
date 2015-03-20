package org.red5.server.mixer;

import java.util.List;

import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.lang.management.OperatingSystemMXBean;
import java.lang.management.ManagementFactory;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

//caution, must install mpstat -P ALL on all servers
public class MinaAgentAdminServerHandler extends IoHandlerAdapter {
	
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);

    private MinaAgentServerStatus status_;
    
    public MinaAgentAdminServerHandler(MinaAgentServerStatus status) {
    	this.status_ = status;
    }
    
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
        	
        	//next read CPU usage
        	long memoryUsage = 0;
            double cpuUsage = 0;
            OperatingSystemMXBean operatingSystemMXBean = (com.sun.management.OperatingSystemMXBean)ManagementFactory.getOperatingSystemMXBean();
        	  for (Method method : operatingSystemMXBean.getClass().getDeclaredMethods()) {
        	    method.setAccessible(true);
        	    if( Modifier.isPublic(method.getModifiers())) {
            	    if (method.getName().startsWith("getFreePhysicalMemorySize") ) {
            	    	Object value;
            	        try {
            	            value = method.invoke(operatingSystemMXBean);
            	            memoryUsage = Long.parseLong(value.toString(), 10);
            	        } catch (Exception e) {
            	        	log.info("cannot read getFreePhysicalMemorySize");
            	        } // try
            	    }
    	            //log.info("======method.getName()="+method.getName());
        	    }
        	} // for getSystemCpuUsage is not working for java 6
        	finalJson.put("cpuload", MinaAgentServerStatus.cpuUsage());
        	finalJson.put("cpuCores", MinaAgentServerStatus.noOfCores());
        	finalJson.put("freememory", memoryUsage/(1024*1024)); //in MegBytes	
        	ret += finalJson.toJSONString();
        } else if(str.contains("GET /disableservice HTTP/")){
        	ret = "Service disabled";
        	status_.changeStatus( MinaAgentServerStatus.DRAIN_STATE );
        } else if(str.contains("GET /enableservice HTTP/")){
        	ret = "Service enabled";
        	status_.changeStatus( MinaAgentServerStatus.UP_STATE );
        } else {
        	ret = "Unknown command";
        }
    	session.write( ret );
        session.close();
    }
}
