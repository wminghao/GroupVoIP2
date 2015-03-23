package org.red5.server.mixer;

import java.util.HashMap;
import java.util.Map;
import java.util.BitSet;
import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.Red5;
import org.slf4j.Logger;

public class MixCoderBridge {
    private Map<Integer, DelegateObject> procIdDelegateMap = new HashMap<Integer, DelegateObject>();
    private Object syncObj = new Object();
    private volatile BitSet reservedProcIds = new BitSet();
    private static Logger log = Red5LoggerFactory.getLogger(Red5.class);

    /////////////////////////
    // public functions
    /////////////////////////
    public interface Delegate {
    	public void newOutput(byte[] bytesRead, int len);		
    }    

    public class DelegateObject{
    	public DelegateObject(MixCoderBridge.Delegate del) {
    		this.delegate = del;
    	}
    	public MixCoderBridge.Delegate delegate;
    }

    public MixCoderBridge() {
    	open();//open the connection to process pipe
    }
    
    //callback from native c code to Java
    public void newOutput(byte[] bytesRead, int len, int procId) {
    	synchronized(syncObj) {
    		DelegateObject obj = procIdDelegateMap.get(new Integer(procId));
    		if ( obj != null ) {     
    			MixCoderBridge.Delegate del = obj.delegate;
    			del.newOutput(bytesRead, len);
    			//log.info("=====>Reading from process pipe={}, procId={}", len, procId);
    		}
    	}
    }
    
    //a new proc
    public int newProc(MixCoderBridge.Delegate del) {
    	int procId = -1;
    	synchronized(syncObj) {
    		procId = reserveProcId();
    		if( procId != -1 ) {
    			DelegateObject obj = new DelegateObject(del);
    			procIdDelegateMap.put( new Integer(procId), obj );
    			if( !startProc( procId )) {
    				log.info("newProc failed:  {}", procId);
        	    	unreserveProcId( procId );
        	    	procIdDelegateMap.remove(new Integer(procId));
    				procId = -1;
    			}
    		}
    	}	

    	return procId;
    }
    public void delProc(int procId) {
    	synchronized(syncObj) {
    		Integer id = new Integer(procId);
    	    DelegateObject obj = procIdDelegateMap.get(id);
    	    if ( obj != null ) {     
				log.info("delProc successful:  {}", procId);
    	    	stopProc( procId );
    	    	unreserveProcId( procId );
    	    	procIdDelegateMap.remove(id);
    	    }
    	}
    }

    //callback from java code to native c code
    public void sendInput( byte[] inputBuf, int len, int procId ) {
    	synchronized(syncObj) {
    	    DelegateObject obj = procIdDelegateMap.get(new Integer(procId));
    	    if ( obj != null ) {     
    	    	newInput( inputBuf, len, procId );
    	    }
    	}
    }

    /////////////////////////
    // private functions
    /////////////////////////
    //map procId to delegate
    private int reserveProcId() {
    	int result = -1;
    	for (int i = 0; true; i++) {
    	    if (!reservedProcIds.get(i)) {
        		reservedProcIds.set(i);
        		result = i;
        		break;
    	    }
    	}
    	return result + 1;
    }

    private void unreserveProcId(int procId) {
    	if (procId > 0) {
    	    reservedProcIds.clear(procId - 1);
    	}
    }

    //open and close thread doing process pipe
    private native void open();

    //start/stop a new proc
    private native boolean startProc(int procId);    
    private native void stopProc(int prodId);

    //calling c code to pass input around
    private native void newInput( byte[] inputBuf, int len, int procId ); 
    static {
    	//Use an absolute path
    	System.load("/usr/share/red5-server-1.0.2-RC4/MixCoderBridge.so");
    	//System.loadLibrary("MixCoderBridge"); 
    } 
}
