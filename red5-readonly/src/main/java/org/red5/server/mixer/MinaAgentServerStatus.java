package org.red5.server.mixer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class MinaAgentServerStatus {

    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);
    
	public static String READY_STATE = "ready";
	public static String DRAIN_STATE = "drain";
	public static String MAINT_STATE = "maint";
	public static String DOWN_STATE = "down";
	public static String UP_STATE = "up";

    private String currentState_ = UP_STATE;
    
    public void changeStatus(String newState) {
    	currentState_ = newState;
    }
    
    public String getStatus() {
    	return currentState_;
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
