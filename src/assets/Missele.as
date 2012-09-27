package assets
{
	

	public class Missele extends Shot
	{
		
		[Embed(source="../../img/missele.png")]
		public var ShotAssetBitmap:Class;
		
		public function Missele() {
			bmpTileSheet = new ShotAssetBitmap();
			
			numSizeTileW = 19;
			numSizeTileH = 6;
			numTilesLenght = 2;
			
			power = 7;
			
			start();
		}
		
		public override function draw():void {
			
			bmpFinal.x = -(numSizeTileW/2);
			bmpFinal.y = -((numSizeTileH/2));
			
			addChild(bmpFinal);
		}
	}
}