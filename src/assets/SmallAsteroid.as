package assets
{
	import flash.display.Bitmap;

	public class SmallAsteroid extends Asteroid {
		
		[Embed(source="../../img/asteroid.png")]
		public var AsteroidAssetBitmap:Class;
		
		public function SmallAsteroid():void {
			
		}
		
		public override function draw():void {
			imgAsteroid = new AsteroidAssetBitmap() as Bitmap;
			imgAsteroid.width = 25;
			imgAsteroid.height = 25;
			imgAsteroid.x = -(imgAsteroid.width/2);
			imgAsteroid.y = -(imgAsteroid.height/2);
			addChild(imgAsteroid);

		}
		
		public override function explode():void {
			
		}
	}
}