package assets
{
	

	public class EletricShot extends Shot
	{
		
		[Embed(source="../../img/shot.png")]
		public var ShotAssetBitmap:Class;
		 
		
		public function EletricShot()
		{
			bmpTileSheet = new ShotAssetBitmap();
			
			power = 5;
			
			start();
		}
	}
}