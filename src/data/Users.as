package data
{
	import com.reyco1.multiuser.data.UserObject;

	public class Users
	{
		
		private var objUser:Object = {};
		
		public function Users()
		{
			
		}
		
		public function registerUser(userData:UserObject):void {
			objUser[userData.id] = userData;
			
			//register the ship, if its you, call another function
			if (userData.id == SpaceShip.Game.connectionHandler.myID) {
				SpaceShip.Game.allShips.setupYourShip(userData.id);
			} else {
				SpaceShip.Game.allShips.addShip(userData.id, userData.name);
			}
		}
		
		public function removeUser(userID:String):void {
			//remove the ship
			SpaceShip.Game.allShips.removeShip(userID);
			
			//remove the shots
			SpaceShip.Game.shotControl.removeAllShotsFromUser(userID);
			
			//remove the object
			objUser[userID] = null;
			delete objUser[userID];
		}
	}
}