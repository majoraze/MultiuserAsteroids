package assets
{
	

	public class Bomb extends Shot
	{
		[Embed(source="../../img/bomb.png")]
		public var ShotAssetBitmap:Class;
		
		public function Bomb() {
			shotType = Shot.TYPE_STATIC;
			
			bmpTileSheet = new ShotAssetBitmap();
			
			numSizeTileW = 8;
			numSizeTileH = 8;
			numTilesLenght = 3;
			
			power = 10;
			
			start();
		}
		
		public override function draw():void {	
			
			bmpFinal.x = -(numSizeTileW/2);
			bmpFinal.y = -((numSizeTileH/2) - 3);
			
			addChild(bmpFinal);
		}
	}
}