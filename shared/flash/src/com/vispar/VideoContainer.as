package com.vispar
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.NetConnection;
	
	import org.red5.flash.bwcheck.ClientServerBandwidth;
	import org.red5.flash.bwcheck.ServerClientBandwidth;
	import org.red5.flash.bwcheck.events.BandwidthDetectEvent;
	
	public class VideoContainer
	{
		//parent container
		protected var container_:Sprite = null;
		
		//delegate
		protected var delegate_:VideoContainerDelegate = null;
		
		//room name
		protected var room:String = null;
		
		//user name
		protected var user:String = null;
		
		//bw detection
		private var netBWConn_:NetConnection = null;	
		private var clientServerService_:String = "checkBandwidthUp"; //must match AbstractScopeAdapter.checkBandwidthUp
		private var serverClientService_:String = "checkBandwidth";   //must match AbstractScopeAdapter.checkBandwidth
		private var onBWInitiated_:Function = null;
		
		//ip address
		protected var serverIp:String = "54.148.16.2";//"54.201.108.66";//"192.168.2.109";//"192.168.0.61";
		
		protected var roomMode_:String; //either auto mode or moderator mode
		
		protected var forceAudioOnly_:Boolean;
		protected var autoPublish_:Boolean;
		
		protected function logDebug(str:String):void {
			delegate_.logDebug(str);
		}
		protected function showAlert(str:String):void {
			delegate_.showAlert(str);
		}
		
		public function VideoContainer(container:Sprite, delegate:VideoContainerDelegate, 
									   room:String, user:String, mode:String, 
									   forceAudioOnly:Boolean, autoPublish:Boolean)
		{ 
			this.container_ = container;
			this.delegate_ = delegate;
			this.room = room;
			this.user = user;
			this.roomMode_ = mode;
			this.forceAudioOnly_ = forceAudioOnly;
			this.autoPublish_ = autoPublish;
		}
		
		public function connectServer():void {
		}
		
		public function disconnectServer():void {
		}
		
		public function selectExternalVideo(videoName:String):void {
		}
		public function stopExternalVideo():void {
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
		public function isAutoMode():Boolean {
			return roomMode_=="auto";
		}
		
		public function approveRequest2Talk(isAllow:Boolean, user:String):void {
		}
		
		protected function initBWEstimator(videoPath:String, onBWInitiated:Function):void {
			// setup connection code
			if( netBWConn_ == null ) {
				netBWConn_ = new NetConnection();
				netBWConn_.connect(videoPath);
				netBWConn_.addEventListener(NetStatusEvent.NET_STATUS, onNetBWConnNetStatus);
				onBWInitiated_ = onBWInitiated;
			}
		}
		protected function stopBWEstimator():void {
			if( netBWConn_ != null ) {
				netBWConn_.close();
				netBWConn_.removeEventListener(NetStatusEvent.NET_STATUS, onNetBWConnNetStatus);
				netBWConn_ = null;
			}
		}
		
		private function onNetBWConnNetStatus(event:NetStatusEvent) : void {
			// did we successfully connect
			if(event.info.code == "NetConnection.Connect.Success") {
				onBWInitiated_();
			}
		}
		
		//Upload speed test is relatively accurate.
		protected function uploadSpeedTest():void
		{
			var clientServer:ClientServerBandwidth  = new ClientServerBandwidth();
			//connect();
			clientServer.connection = netBWConn_;
			clientServer.service = clientServerService_;
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_COMPLETE,onClientServerComplete);
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_STATUS,onClientServerStatus);
			clientServer.addEventListener(BandwidthDetectEvent.DETECT_FAILED,onDetectFailed);
			clientServer.start();
		}
		
		//Download speed test is NOT accurate.
		protected function downloadSpeedTest(netConn:NetConnection):void
		{
			var serverClient:ServerClientBandwidth = new ServerClientBandwidth();
			//connect();
			serverClient.connection = netBWConn_;
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
		
		protected function onClientServerComplete(event:BandwidthDetectEvent):void
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
			//ClientServer();
		}
		
		private function onServerClientStatus(event:BandwidthDetectEvent):void
		{	
			if (event.info) {
				//logDebug("\n count: "+event.info.count+ " sent: "+event.info.sent+" timePassed: "+event.info.timePassed+" latency: "+event.info.latency+" cumLatency: " + event.info.cumLatency);
			}
		}

	}
}