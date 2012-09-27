package assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Shot extends Sprite {
		//type of shots
		public static var NORMAL_SHOT:String = 'normalShot';
		public static var EXPLOSIVE_SHOT:String = 'explosiveShot';
		
		public static var TYPE_TRAVALER:String = 'typeTraveler';
		public static var TYPE_STATIC:String = 'typeStatic';
		
		public var maxShots:Number = 3;
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var angle:Number = 0;
		public var thrust:Number = 1.5;
		public var isShotting:Boolean = false;
		
		public var bmpTileSheet:Bitmap;
		
		public var numSizeTileW:Number = 12;
		public var numSizeTileH:Number = 12;
		private var numAniIndex:Number = 0;
		private var numAniCount:Number = 0;
		private var numAniDelay:Number = 1;
		public var numTilesLenght:Number = 3;
		private var bmdFinal:BitmapData = new BitmapData(numSizeTileW,numSizeTileH,true,0x000000);
		public var bmpFinal:Bitmap = new Bitmap(bmdFinal);
		private var recTile:Rectangle = new Rectangle(0,0,numSizeTileW,numSizeTileH);
		
		public var shotStyle:String = NORMAL_SHOT;
		public var shotType:String = TYPE_TRAVALER;
		
		public var id:String = '';
		
		public var senderID:String = '';
		public var vxShip:Number = 0;
		public var vyShip:Number = 0;
		
		public var power:Number = 10;
		
		public function Shot() {			
			//start();
		}
		
		public function start():void {
			bmdFinal = new BitmapData(numSizeTileW,numSizeTileH,true,0x000000);
			bmpFinal = new Bitmap(bmdFinal);
			recTile = new Rectangle(0,0,numSizeTileW,numSizeTileH);
			
			draw();
		}
		
		public function draw():void {
			
			bmpFinal.x = -(numSizeTileW/2);
			bmpFinal.y = -(numSizeTileH/2);
			
			addChild(bmpFinal);
		}
		
		public function shot():void {
			//bmpFinal.rotation = angle;
			
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateFire);
			this.addEventListener(Event.ENTER_FRAME, animateFire);
			
		}
		
		public function removeShot():void {
			if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, animateFire);
		}
		
		private function animateFire(e:Event):void {
			if (numAniCount == numAniDelay) {
				numAniIndex++;
				numAniCount = 0;
				if (numAniIndex == numTilesLenght){
					numAniIndex = 0;
				}
			} else {
				numAniCount++;
			}
			
			
			recTile.width = numSizeTileW;
			recTile.height = numSizeTileH;
			
			recTile.x = int((numAniIndex % numTilesLenght))*numSizeTileW;
			recTile.y = int((numAniIndex / numTilesLenght))*numSizeTileH;
			
			bmdFinal.copyPixels(bmpTileSheet.bitmapData,recTile, new Point(0,0));
		}
		
		public function get bitmapData():BitmapData {
			return bmdFinal;
		}
		
	}

}