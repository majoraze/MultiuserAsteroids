package assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class Asteroid extends Sprite {
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var angle:Number = 30;
		public var imgAsteroid:Bitmap;
		public var score:Number = 100;
		
		public function Asteroid() {
			draw();
		}
		
		public function draw():void {
			
		}
		
		public function explode():void {
			
		}
		
		public function clear():void {
			
		}
		
		public function get bitmapData():BitmapData {
			return imgAsteroid.bitmapData;
		}
	}
}