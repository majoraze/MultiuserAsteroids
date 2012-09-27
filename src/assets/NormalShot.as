package assets
{
	public class NormalShot extends Shot
	{
		public function NormalShot()
		{
			power = 2;
			start();
		}
		
		public override function draw():void {
			graphics.beginFill(0xffffff,1);
			graphics.drawCircle(-0.5,-0.5,1);
			graphics.endFill();
		}
		
		public override function shot():void {
			
		}
		
		public override function removeShot():void {
			
		}
		
	}
}