package controllers
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import actions.Life;
	import actions.Shots;
	
	import assets.Ship;

	public class YourShipControl
	{
		
		public var shotControl:Shots;
		public var scoreControl:YourScoreControl;
		private var _ship:Ship;
		private var id:String = '';
		
		public var lifeBar:Life = new Life();
		
		public function YourShipControl(userID:String='')
		{
			id = userID;
		}
		
		public function setupShip():void {
			_ship = new Ship();
			ship.id = id;
			ship.rotation = 0;
			ship.vr = 0;
			ship.thrust = 0;
			ship.vx = 0;
			ship.vy = 0;
			ship.x = SpaceShip.Game.stage.stageWidth/2;
			ship.y = SpaceShip.Game.stage.stageHeight/2;
			ship.startShowing();
			
			lifeBar = new Life();
			lifeBar.draw();
			SpaceShip.Game.addChild(lifeBar);
			
			ship.life = lifeBar;

			setupKeys();
		}
		
		private function setupKeys():void {
			SpaceShip.Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			SpaceShip.Game.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function updatePosition():void {
			var curShip:Ship = _ship as Ship;
			
			curShip.rotation += curShip.vr;
			
			var angle:Number = curShip.rotation * Math.PI/180;
			var ax:Number = Math.cos(angle) * curShip.thrust;
			var ay:Number = Math.sin(angle) * curShip.thrust;
			curShip.vx += ax;
			curShip.vy += ay;
			
			curShip.vx *= SpaceShip.Game.friction;
			curShip.vy *= SpaceShip.Game.friction;
			
			curShip.x += curShip.vx;
			curShip.y += curShip.vy;
			
			lifeBar.x = curShip.x - (lifeBar.width/2);
			lifeBar.y = curShip.y + 25;
			
			//boundaries
			var left:Number = 0;
			var right:Number = SpaceShip.Game.stage.stageWidth;
			var top:Number = 0;
			var bottom:Number = SpaceShip.Game.stage.stageHeight;
			
			//left and right boundaries
			if(curShip.x - curShip.width/2 > right) {
				curShip.x = left - curShip.width/2;
			} else if (curShip.x + curShip.width/2 < left) {
				curShip.x = right + curShip.width/2;
			}
			
			//top and bottom boundaries
			if (curShip.y - curShip.height/2 > bottom) {
				curShip.y = top - curShip.height/2;
			} else if (curShip.y < top - curShip.height/2) {
				curShip.y = bottom + curShip.height/2;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void {
			
			switch(e.keyCode) {
				case Keyboard.LEFT:
					_ship.vr = -5;
				break;
				
				case Keyboard.RIGHT:
					_ship.vr = 5;
				break;
				
				case Keyboard.UP:
					_ship.thrust = .3;
					_ship.draw(true);
				break;
				
				case Keyboard.SPACE:
					handleShot();
				break;
				
				case Keyboard.NUMBER_1:
					SpaceShip.Game.shotControl.currentWeaponId = 0;
				break;
				
				case Keyboard.NUMBER_2:
					SpaceShip.Game.shotControl.currentWeaponId = 1;
				break;
				
				case Keyboard.NUMBER_3:
					SpaceShip.Game.shotControl.currentWeaponId = 2;
				break;
				
				case Keyboard.NUMBER_4:
					SpaceShip.Game.shotControl.currentWeaponId = 3;
				break;
				
				default:
				break;
			}
			
		}
		
		private function handleShot():void {
			SpaceShip.Game.shotControl.addShot(SpaceShip.Game.connectionHandler.myID);
		}
		
		private function onKeyUp(e:KeyboardEvent):void {			
			switch(e.keyCode) {
				case Keyboard.LEFT:
					_ship.vr = 0;
				break;
				
				case Keyboard.RIGHT:
					_ship.vr = 0;
				break;
				
				case Keyboard.UP:
					_ship.thrust = 0;
					_ship.draw(false);
				break;
				
				default:
				break;
			}
		}
		
		public function get ship():Ship {
			return _ship;
		}
	}
}