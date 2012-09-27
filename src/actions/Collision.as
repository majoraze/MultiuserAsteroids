package actions
{
	import assets.Explosion;
	import assets.Ship;
	import assets.Shot;

	public class Collision
	{
		public function Collision()
		{
		}
		
		public function checkCollisions():void {
			shotWithShips();
		}
		
		private function shotWithShips():void {
			var arrShips:Array = SpaceShip.Game.allShips.getAllShips();
			
			for (var i:int = 0; i < arrShips.length; i++) {
				
				var currentShip:Ship = arrShips[i];
				
				for (var j:int = 0; j < SpaceShip.Game.shotControl.currentShottingArray.length; j++) {
					
					var currentShot:Shot = SpaceShip.Game.shotControl.currentShottingArray[j];
					
					if ((currentShip.id != currentShot.senderID)) {
						
						//trace(currentShip.id , currentShot.senderID);
						
						if (currentShot.hitTestObject(currentShip)) {
							SpaceShip.Game.shotControl.removeShot(j);
							
							//SpaceShip.Game.connectionHandler.sendLifeData(currentShot.power);
							currentShip.life.decrease(currentShot.power);
							
							//VERIFICARA SE ACABOU A VIDA PARA FAZER A EXPLOSAO RESPECTIVA, REDUZIR A VIDA, E INICIAR DE NOVO
							var explosionAsteroid:Explosion = new Explosion();
							explosionAsteroid.x = currentShip.x;
							explosionAsteroid.y = currentShip.y;
							explosionAsteroid.scaleX = .3;
							explosionAsteroid.scaleY = .3;
							explosionAsteroid.addCallBack(removeExplosion);
							SpaceShip.Game.addChild(explosionAsteroid);
						}	
					}
				}
			}
		}
		
		private function removeExplosion(pExplosionRemove:Explosion):void {
			SpaceShip.Game.removeChild(pExplosionRemove);
		}
		
	}
}