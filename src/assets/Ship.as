package assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import actions.Life;
	
	public class Ship extends Sprite {
		
		[Embed(source="../../img/spaceship.png")]
		public var ShipAssetBitmap:Class;
		
		private var numSizeTile:Number = 32;
		private var numAniIndex:Number = 1;
		private var numAniCount:Number = 0;
		private var numAniDelay:Number = 3;
		private var numTilesLenght:Number = 3;
		private var bmpTileSheet:Bitmap = new ShipAssetBitmap();
		private var bmdFinal:BitmapData = new BitmapData(numSizeTile,numSizeTile,true,0x000000);
		private var bmpFinal:Bitmap = new Bitmap(bmdFinal);
		private var recTile:Rectangle = new Rectangle(0,0,numSizeTile,numSizeTile);
		
		public var vr:Number = 0;
		public var thrust:Number = 0;
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public var id:String = '';
		public var userName:String = '';
		
		public var thrusting:Boolean = false;
		
		public var life:Life;
		
		public function Ship() {
			bmpFinal.x = (numSizeTile/2);
			bmpFinal.y = -(numSizeTile/2);
			bmpFinal.rotation = 90;
			
			draw(false);
		}
		
		public function draw(showFlame:Boolean):void {
			
			if (showFlame) {
				//			graphics.moveTo(-7.5,-5);
				//			graphics.lineTo(-15,0);
				//			graphics.lineTo(-7.5,5);
				
				thrusting = true;
				
				if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateFire);
				this.addEventListener(Event.ENTER_FRAME, animateFire);
				
			} else {
				if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateFire);
				
				recTile.x = 0;
				recTile.y = 0;
				
				bmdFinal.copyPixels(bmpTileSheet.bitmapData,recTile,new Point(0,0));
				
				thrusting = false;
			}
		}
		
		private function animateFire(e:Event):void {
			if (numAniCount == numAniDelay) {
				numAniIndex++;
				numAniCount = 0;
				if (numAniIndex == numTilesLenght){
					numAniIndex = 1;
				}
			} else {
				numAniCount++;
			}
			
			recTile.x = int((numAniIndex % numTilesLenght))*numSizeTile;
			recTile.y = int((numAniIndex / numTilesLenght))*numSizeTile;
			
			bmdFinal.copyPixels(bmpTileSheet.bitmapData,recTile, new Point(0,0));
		}
		
		public function startShowing():void {
			addChild(bmpFinal);
		}
		
		public function stopAnimation():void {
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateFire);
			removeChild(bmpFinal);
		}
		
		public function get bitmapData():BitmapData {
			return bmdFinal;
		}
	}

}