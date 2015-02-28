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
        	finalJson.put("cpuload", cpuUsage(CONSERVATIVE));
        	finalJson.put("freememory", memoryUsage);	
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

    public static final int CONSERVATIVE    = 0;
    public static final int AVERAGE     = 1;
    public static final int OPTIMISTIC  = 2;
    /**
     * cpuUsage gives us the percentage of cpu usage
     * 
     * mpstat -P ALL out stream example:
     *
     *  Linux 3.2.0-30-generic (castarco-laptop)    10/09/12    _x86_64_    (2 CPU)                 - To discard
     *                                                                                              - To discard
     *  00:16:30  AM   CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %gnice %idle    - To discard
     *  00:16:30  AM   all   17,62    0,03    3,55    0,84    0,00    0,03    0,00    0,00   0      77,93
     *  00:16:30  AM     0   17,36    0,05    3,61    0,83    0,00    0,05    0,00    0,00   0      78,12
     *  00:16:30  AM     1   17,88    0,02    3,49    0,86    0,00    0,01    0,00    0,00   0      77,74
     * 
     * @param measureMode Indicates if we want optimistic, convervative or average measurements.
     */
    public static Double cpuUsage (int measureMode) throws Exception {

        BufferedReader mpstatReader = null;

        String      mpstatLine;
        String[]    mpstatChunkedLine;

        Double      selected_idle;

        try {
            Runtime runtime = Runtime.getRuntime();
            Process mpstatProcess = runtime.exec("mpstat -P ALL");

            mpstatReader = new BufferedReader(new InputStreamReader(mpstatProcess.getInputStream()));

            // We discard the three first lines
            mpstatReader.readLine();
            mpstatReader.readLine();
            mpstatReader.readLine();

            mpstatLine = mpstatReader.readLine();
            if (mpstatLine == null) {
                throw new Exception("mpstat didn't work well");
            } else if (measureMode == AVERAGE) {
                mpstatChunkedLine = mpstatLine.replaceAll(",", ".").split("\\s+");
                selected_idle = Double.parseDouble(mpstatChunkedLine[12]);
            } else {
                selected_idle   = (measureMode == CONSERVATIVE)?200.:0.;
                Double candidate_idle;

                int i = 0;
                while((mpstatLine = mpstatReader.readLine()) != null) {
                    mpstatChunkedLine = mpstatLine.replaceAll(",", ".").split("\\s+");
                    candidate_idle = Double.parseDouble(mpstatChunkedLine[12]);

                    if (measureMode == CONSERVATIVE) {
                        selected_idle = (selected_idle < candidate_idle)?selected_idle:candidate_idle;
                    } else if (measureMode == OPTIMISTIC) {
                        selected_idle = (selected_idle > candidate_idle)?selected_idle:candidate_idle;
                    }
                    ++i;
                }
                if (i == 0) {
                    throw new Exception("mpstat didn't work well");
                }
            }
        } catch (Exception e) {
            throw e; // It's not desirable to handle the exception here
        } finally {
            if (mpstatReader != null) try {
                mpstatReader.close();
            } catch (IOException e) {
                // Do nothing
            }
        }

        return  100-selected_idle;
    }

}
