package assets
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Explosion extends Sprite {
		
		[Embed(source="../../img/explosion-ship.png")]
		public var ExplosionAssetBitmap:Class;
		
		private var numSizeTile:Number = 70;
		private var numAniIndex:Number = 0;
		private var numAniCount:Number = 0;
		public var numAniDelay:Number = 2;
		private var numTilesLenght:Number = 7;
		private var bmpTileSheet:Bitmap = new ExplosionAssetBitmap();
		private var bmdFinal:BitmapData = new BitmapData(numSizeTile,numSizeTile,true,0x000000);
		private var bmpFinal:Bitmap = new Bitmap(bmdFinal);
		private var recTile:Rectangle = new Rectangle(0,0,numSizeTile,numSizeTile);
		
		private var fncCallBack:Function;
		
		public function Explosion() {
			draw();
		}
		
		public function draw():void {
			bmpFinal.x = -(numSizeTile/2);
			bmpFinal.y = -(numSizeTile/2);
			
			addChild(bmpFinal);
			
			this.addEventListener(Event.ENTER_FRAME, animateExplosion);
		}
		
		public function removeExplosion():void {
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateExplosion);
			
			if (fncCallBack != null) {
				fncCallBack.call(null, this);
			}
		}
		
		public function addCallBack(pFunction:Function):void {
			fncCallBack = pFunction;
		}
		
		private function animateExplosion(e:Event):void {
			if (numAniCount == numAniDelay) {
				numAniIndex++;
				numAniCount = 0;
				if (numAniIndex == numTilesLenght) {
					removeExplosion();
				}
			} else {
				numAniCount++;
			}
			
			recTile.x = int((numAniIndex % numTilesLenght))*numSizeTile;
			recTile.y = int((numAniIndex / numTilesLenght))*numSizeTile;
			
			bmdFinal.copyPixels(bmpTileSheet.bitmapData,recTile, new Point(0,0));
		}
		
	}

}