package com.vispar
{
	import flash.display.Sprite;
	import flash.net.NetConnection;
	
	import org.red5.flash.bwcheck.ClientServerBandwidth;
	import org.red5.flash.bwcheck.ServerClientBandwidth;
	import org.red5.flash.bwcheck.events.BandwidthDetectEvent;
	
	public class VideoContainer
	{
		//parent container
		protected var container_:Sprite = null;
		
		//netconnection
		protected var netConn:NetConnection = null;	
		
		//delegate
		protected var delegate_:VideoContainerDelegate = null;
		
		//room name
		protected var room:String = null;
		
		//user name
		protected var user:String = null;
		
		//bw detection
		private var clientServerService_:String = "checkBandwidthUp"; //must match AbstractScopeAdapter.checkBandwidthUp
		private var serverClientService_:String = "checkBandwidth";   //must match AbstractScopeAdapter.checkBandwidth
		
		//ip address
		protected var serverIp:String = "54.148.16.2";//"54.201.108.66";//"192.168.2.109";//"192.168.0.61";
		protected function logDebug(str:String):void {
			delegate_.logDebug(str);
		}
		protected function showAlert(str:String):void {
			delegate_.showAlert(str);
		}
		
		public function VideoContainer(container:Sprite, delegate:VideoContainerDelegate, room:String, user:String)
		{ 
			this.container_ = container;
			this.delegate_ = delegate;
			this.room = room;
			this.user = user;
		}
		
		public function connectServer():void {
		}
		
		public function disconnectServer():void {
		}
		
		public function selectVideo(videoName:String):void {
		}
		public function stopVideo():void {
		}
		
		public function isViewOnly():Boolean {
			return false;
		}
		public function switchToViewOnly(forceViewOnly:Boolean):void {			
		}
		public function isAudioOnly():Boolean {
			return false;
		}
		public function switchToAudioOnly(forceAudioOnly:Boolean):void {			
		}
		
		private function ClientServer():void
		{
			var clientServer:ClientServerBandwidth  = new ClientServerBandwidth();
			//connect();
			clientServer.connection = netConn;
			clientServer.service = clientServerService_;
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_COMPLETE,onClientServerComplete);
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_STATUS,onClientServerStatus);
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_FAILED,onDetectFailed);
			clientServer.start();
		}
		
		protected function ServerClient():void
		{
			var serverClient:ServerClientBandwidth = new ServerClientBandwidth();
			//connect();
			serverClient.connection = netConn;
			serverClient.service = serverClientService_;
			serverClient.addEventListener(BandwidthDetectEvent.DETECT_COMPLETE,onServerClientComplete);
			serverClient.addEventListener(BandwidthDetectEvent.DETECT_STATUS,onServerClientStatus);
			serverClient.addEventListener(BandwidthDetectEvent.DETECT_FAILED,onDetectFailed);
			serverClient.start();
		}
		
		private function onDetectFailed(event:BandwidthDetectEvent):void
		{
			logDebug("Detection failed with error: " + event.info.application + " " + event.info.description);
		}
		
		private function onClientServerComplete(event:BandwidthDetectEvent):void
		{			
			logDebug("\n\n kbitUp = " + event.info.kbitUp + ", deltaUp= " + event.info.deltaUp + ", deltaTime = " + event.info.deltaTime + ", latency = " + event.info.latency + " KBytes " + event.info.KBytes);
		}
		
		private function onClientServerStatus(event:BandwidthDetectEvent):void
		{
			if (event.info) {
				//logDebug("\n count: "+event.info.count+ " sent: "+event.info.sent+" timePassed: "+event.info.timePassed+" latency: "+event.info.latency+" overhead:  "+event.info.overhead+" packet interval: " + event.info.pakInterval + " cumLatency: " + event.info.cumLatency);
			}
		}
		
		private function onServerClientComplete(event:BandwidthDetectEvent):void
		{
			logDebug("\n\n kbitDown: " + event.info.kbitDown + " deltaDown: " + event.info.deltaDown + " deltaTime: " + event.info.deltaTime + " latency: " + event.info.latency);
			ClientServer();
		}
		
		private function onServerClientStatus(event:BandwidthDetectEvent):void
		{	
			if (event.info) {
				//logDebug("\n count: "+event.info.count+ " sent: "+event.info.sent+" timePassed: "+event.info.timePassed+" latency: "+event.info.latency+" cumLatency: " + event.info.cumLatency);
			}
		}

	}
}