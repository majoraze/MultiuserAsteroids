package connection
{
	import com.reyco1.multiuser.MultiUserSession;
	import com.reyco1.multiuser.data.UserObject;
	import com.reyco1.multiuser.debug.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import assets.Ship;

	public class ConnectionControl extends EventDispatcher
	{
		
		private var conMulti:MultiUserSession;
		
		private const SERVER:String   = "rtmfp://p2p.rtmfp.net/6d019c52f566bf47e85ee90e-c58f58013d97/";
		private const DEVKEY:String   = "6d019c52f566bf47e85ee90e-c58f58013d97";
		private const SERV_KEY:String = SERVER + DEVKEY;
		
		//EVENTS
		public static const CONNECTED:String = 'connected';
		public static const TYPE_SHIP:String = 'ship';
		public static const TYPE_LIFE:String = 'life';
		public static const TYPE_SHOTS:String = 'shots';
		
		public var myID:String = '';
		
		
		public function ConnectionControl()
		{
			Logger.LEVEL = Logger.OWN;
			Logger.log("Initialize");
		}
		
		public function connectP2P():void {
			
			var userName:String  = "User_" + Math.round(Math.random()*100);
			
			conMulti = new MultiUserSession(SERV_KEY, "multiuser/test");
			
			conMulti.onConnect 			= handleConnect;
			conMulti.onUserAdded 		= handleUserAdded;
			conMulti.onUserRemoved 		= handleUserRemoved;
			conMulti.onObjectRecieve 	= handleGetObject;
			
			conMulti.connect(userName, {teste:'teste'});
		}
		
		private function handleConnect(user:UserObject):void
		{
			Logger.log("I'm connected: " + user.name + ", total: " + conMulti.userCount);
			
			myID = user.id;
			
			SpaceShip.Game.users.registerUser(user);
			dispatchEvent(new Event(ConnectionControl.CONNECTED));
		}
		
		private function handleUserAdded(user:UserObject):void
		{
			Logger.log("User added: " + user.name + ", total users: " + conMulti.userCount);
			
			
			SpaceShip.Game.users.registerUser(user);
			
			sendYourData();
		}
		
		private function handleUserRemoved(user:UserObject):void
		{
			Logger.log("User disconnected: " + user.name + ", total users: " + conMulti.userCount); 
			
			SpaceShip.Game.users.removeUser(user.id);
		}
		
		public function sendYourData(event:Event = null):void			
		{
			conMulti.sendObject({type:ConnectionControl.TYPE_SHIP, x:SpaceShip.Game.allShips.you.ship.x, y:SpaceShip.Game.allShips.you.ship.y, rotation:SpaceShip.Game.allShips.you.ship.rotation, thrusting:SpaceShip.Game.allShips.you.ship.thrusting});
		}
		
		public function sendShotData(shotObject:Object):void {
			conMulti.sendObject(shotObject);
		}
		
		public function sendLifeData(pLife:Number):void {
			conMulti.sendObject({life:pLife, type:ConnectionControl.TYPE_LIFE});
		}
		
		private function handleGetObject(peerID:String, data:Object):void
		{
			
			//update ship positions
			if (data.type == ConnectionControl.TYPE_SHIP) {
				SpaceShip.Game.allShips.updateUserPosition(peerID, data);
			}
			
			if (data.type == ConnectionControl.TYPE_SHOTS) {
				//SpaceShip.Game.allShips.updateUserPosition(peerID, data);
				SpaceShip.Game.shotControl.addShot(peerID, data);
			}
			
			
			
			/*
			
			if (data.shots != null) {
				if (otherUserShots[peerID] == null) {
					otherUserShots[peerID] = [];
				}
				
				for (var i:int = 0; i < otherShotsControl.arrShots.length; i++) {
					if (otherShotsControl.getShot(data.shots[i].id, peerID) == null){
						//remove this item from stage
						removeOtherShot(i);
					}
				}
				
				otherUserShots[peerID] = data.shots;
				
				if (otherUserShots[peerID] != null) {
					var shotsArrayUser:Array = otherUserShots[peerID];
					
					for (var b:int = 0; b < shotsArrayUser.length; b++) {
						otherShotsControl.addShot(shotsArrayUser[b], peerID);
					}
				}
				
			}*/
		}
	}
}