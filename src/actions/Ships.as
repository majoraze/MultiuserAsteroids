package actions
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import assets.Ship;
	
	import controllers.YourShipControl;

	public class Ships
	{
		
		private var ships:Object = {};
		private var userNames:Object = {};
		private var lifeBars:Object = {};
		public var you:YourShipControl;
		
		public function Ships()
		{
			
		}
		
		public function setupYourShip(userID:String):void {
			you = new YourShipControl(userID);
			you.setupShip();
			you.ship.userName = 'me';
			
			SpaceShip.Game.addChild(you.ship);
		}
		
		public function addShip(userID:String, userName:String):void {
			ships[userID] = new Ship();
			ships[userID].id = userID;
			ships[userID].startShowing();
			
			//for not show on stage while adding and connecting
			ships[userID].x = -100;
			ships[userID].y = -100;
			ships[userID].userName = userName;
			
			SpaceShip.Game.addChild( ships[userID] );
			
			//name that follows ships
			userNames[userID] = new TextField();
			userNames[userID].mouseEnabled = false;
			userNames[userID].textColor = 0xFFFFFF;
			userNames[userID].autoSize = TextFieldAutoSize.LEFT;
			userNames[userID].text = userName;
			
			//adding the lifebar
			lifeBars[userID] = new Life();
			lifeBars[userID].draw();
			SpaceShip.Game.addChild(lifeBars[userID]);
			
			ships[userID].life = lifeBars[userID];
			
			//for not show on stage while adding and connecting
			userNames[userID].x = -100;
			userNames[userID].y = -100;
			
			SpaceShip.Game.addChild(userNames[userID]);
		}
		
		public function removeShip(userID:String):void {
			SpaceShip.Game.removeChild( ships[userID] );
			ships[userID] = null;
			
			SpaceShip.Game.removeChild( userNames[userID] );
			userNames[userID] = null;
			
			SpaceShip.Game.removeChild( lifeBars[userID] );
			lifeBars[userID] = null;
			
			delete ships[userID];
			delete userNames[userID];
			delete lifeBars[userID];
		}
		
		public function update():void {
			updateYourPosition();
			//updateUsersPosition(); WILL UPDATE WHEN DATA RECEIVED
		}
		
		public function updateYourPosition():void {
			you.updatePosition();
		}
		
		public function getAllShips():Array {
			var arrShips:Array = [];
			
			for (var i:String in ships) {
				arrShips.push(ships[i]);
			}
			
			arrShips.push(you.ship);
			
			return arrShips;
		}
		
		public function updateUserPosition(userID:String, data:Object):void {
			
			if (ships[userID] != null) {
				ships[userID].x = data.x;
				ships[userID].y = data.y;
				ships[userID].rotation = data.rotation;
				ships[userID].draw(data.thrusting);
				
				userNames[userID].x = ships[userID].x - (userNames[userID].textWidth/2);
				userNames[userID].y = ships[userID].y + 35;
				
				lifeBars[userID].x = ships[userID].x - (lifeBars[userID].width/2);
				lifeBars[userID].y = ships[userID].y + 25;
			}
			
		}
	}
}