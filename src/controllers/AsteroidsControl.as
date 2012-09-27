package controllers
{
	import assets.Asteroid;
	import assets.BigAsteroid;
	import assets.SmallAsteroid;

	public class AsteroidsControl
	{
		public static var arrAsteroids:Array = [];
		
		public static function addAsteroid():void {
			
		}
		
		public static function removeAsteroid(pIndice:Number, isEnd:Boolean = false):void {
			var asteroid:Asteroid = arrAsteroids[pIndice] as Asteroid;
			
			arrAsteroids.splice(pIndice,1);
			
			SpaceShip.Game.removeChild(asteroid);
			
			if (asteroid is BigAsteroid) {
				if (!isEnd) {
					//cria 2 novos asteroids
					for (var i:int = 0; i < 2; i++) {
						var newAsteroid:SmallAsteroid = new SmallAsteroid();
						newAsteroid.x = asteroid.x;
						newAsteroid.y = asteroid.y;
						
						newAsteroid.vx = Math.random() * 2.5 - 1.5;
						newAsteroid.vy = Math.random() * 2.5 - 1.5;
						
						SpaceShip.Game.addChild(newAsteroid);
						
						arrAsteroids.push(newAsteroid);
					}
				}
			}
		}
	}
}