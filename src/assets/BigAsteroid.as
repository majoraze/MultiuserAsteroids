package assets
{
	import flash.display.Bitmap;
	
	public class BigAsteroid extends Asteroid {
		
		[Embed(source="../../img/asteroid.png")]
		public var AsteroidAssetBitmap:Class;
		
		public function BigAsteroid():void {
			
		}
		
		public override function draw():void {
			imgAsteroid = new AsteroidAssetBitmap() as Bitmap;
			imgAsteroid.x = -(imgAsteroid.width/2);
			imgAsteroid.y = -(imgAsteroid.height/2);
			addChild(imgAsteroid);
		}
		
		public override function explode():void {
			
		}
	}
}