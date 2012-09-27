package actions
{
	import flash.display.Sprite;

	public class Life extends Sprite
	{
		private var numLife:Number = 100;
		private var numWidthBar:Number = 30;
		
		public function Life()
		{
			
		}
		
		public function draw():void {
			var numBarraLife:Number = numWidthBar*numLife/100;
			var numResto:Number = 30 - numBarraLife;
			
			this.graphics.clear();
			this.graphics.beginFill(0x00FF00,1);
			this.graphics.drawRect(0,0,numBarraLife, 5);
			this.graphics.beginFill(0xFF0000,1);
			this.graphics.drawRect(numBarraLife,0,numResto, 5);
			this.graphics.endFill();
		}
		
		public function decrease(pPower:Number):void {
			if (numLife - pPower <= 0) {
				death();
				return;
			}
			
			numLife -= pPower;
			
			draw();
		}
		
		public function increase(pLife:Number):void {
			numLife += pLife;
			
			if (numLife > 100) {	
				numLife = 100;
			}
			
			draw();
		}
		
		private function death():void {
			trace('murio');
		}
	}
}