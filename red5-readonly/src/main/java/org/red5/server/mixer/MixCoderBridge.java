package org.red5.server.mixer;

import java.nio.ByteBuffer;

public class MixCoderBridge {
    public interface Delegate {
	public void newOutput(byte[] bytesRead, int len);		
    }
    
    private Delegate delegate;
    MixCoderBridge(Delegate del) {
	this.delegate = del;
	open();//open the connection to process pipe
    }
    
    //callback from native c code
    public void newOutput(byte[] bytesRead, int len) {
	this.delegate.newOutput(bytesRead, len);
    }
    
    //open and close thread doing process pipe
    private native void open();
    public native void close(); 
    
    //calling c code to pass input around
    public native void newInput( byte[] inputBuf, int len ); 
    static { 
	System.loadLibrary("MixCoderBridge"); 
    } 
}
