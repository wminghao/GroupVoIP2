package org.red5.server.mixer;

import java.util.List;

import org.apache.mina.core.session.IdleStatus;
import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.lang.Process;
import java.lang.Runtime;

import java.lang.management.OperatingSystemMXBean;
import java.lang.management.ManagementFactory;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

//caution, must install mpstat -P ALL on all servers
public class MinaLoadServerHandler extends IoHandlerAdapter {

	private static String READY_STATE = "ready";
	private static String DRAIN_STATE = "drain";
	private static String MAINT_STATE = "maint";
	private static String DOWN_STATE = "down";
	private static String UP_STATE = "up";
	
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
    private String currentState_ = UP_STATE;
    
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
        	finalJson.put("cpuload", cpuUsage());
        	finalJson.put("cpuCores", noOfCores());
        	finalJson.put("freememory", memoryUsage/(1024*1024)); //in MegBytes	
        	ret += finalJson.toJSONString();
        } else if(str.contains("GET /disableservice HTTP/")){
        	ret = "Service disabled";
        	currentState_ = DRAIN_STATE;
        } else if(str.contains("GET /enableservice HTTP/")){
        	ret = "Service enabled";
        	currentState_ = UP_STATE;
        } else {
        	int cpuUsageAvg = (((int)(cpuUsage() * 100.00)) / noOfCores());
        	int percentageIdle = cpuUsageAvg>100?0:(100-cpuUsageAvg);
        	ret = String.valueOf(percentageIdle)+"%,"+currentState_+"\n";	
        	log.info("======load balancer query, ret={}", ret);
        }
    	session.write( ret );
        session.close();
    }
    @Override
    public void sessionIdle( IoSession session, IdleStatus status ) throws Exception
    {
    	log.info( "IDLE " + session.getIdleCount( status ));
    }

    public static int noOfCores (){        
        return Runtime.getRuntime().availableProcessors();
    }
    //average last minute
    public static Double cpuUsage () {

        BufferedReader mpstatReader = null;

        String      mpstatLine;
        String[]    mpstatChunkedLine;

        Double      totalUsage = 0.0;

        try {
            Runtime runtime = Runtime.getRuntime();
            Process mpstatProcess = runtime.exec("cat /proc/loadavg");

            mpstatReader = new BufferedReader(new InputStreamReader(mpstatProcess.getInputStream()));
            if((mpstatLine = mpstatReader.readLine()) != null) {
                mpstatChunkedLine = mpstatLine.replaceAll(",", ".").split("\\s+");
                totalUsage = Double.parseDouble(mpstatChunkedLine[0]);
            }          
        	//log.info("totalUsage={}, mpstatLine={}", totalUsage, mpstatLine);   
        } catch (Exception e) {
        	log.info("noOfCores exception={}", e);
        } finally {
            if (mpstatReader != null) try {
                mpstatReader.close();
            } catch (IOException e) {
                // Do nothing
            }
        }
        return totalUsage;
    }
    public static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }
}
