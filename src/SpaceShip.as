package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import actions.Collision;
	import actions.Ships;
	import actions.Shots;
	
	import assets.Asteroid;
	import assets.BigAsteroid;
	import assets.Explosion;
	import assets.SmallAsteroid;
	
	import connection.ConnectionControl;
	
	import data.Users;
	
	[SWF(width='1024', height='768', backgroundColor='#000000', frameRate='30')]
	public class SpaceShip extends Sprite {
		
		public static var Game:SpaceShip;
		
		
		public var friction:Number = 0.98;
		private var asteroids:Array = [];
		private var totalAsteroids:Number = 14;
		private var protectionRange:Number = 200;
		private var shpBackground:Shape;
		
		
		
		
		
		public var connectionHandler:ConnectionControl;
		public var allShips:Ships;
		public var users:Users;
		public var shotControl:Shots;
		public var collisionControl:Collision;
		
		public function SpaceShip() {
			SpaceShip.Game = this;
			
			if (stage) {
				init()
			} else {
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
		}
		
		private function init(e:Event = null):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			shpBackground = new Shape();
			addChild(shpBackground);
			
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
			
			//inicia a classe que irá controlar os usuários
			users = new Users();
			
			//inicia a classe de controle das naves
			allShips = new Ships();
			
			//inicia a classe de controle dos tiros
			shotControl = new Shots();
			shotControl.setup();
			shotControl.buildShotInfo();
			
			collisionControl = new Collision();
			
			connectionHandler = new ConnectionControl();
			connectionHandler.connectP2P();
			
			connectionHandler.addEventListener(ConnectionControl.CONNECTED, initGame);
		}
		
		public function initGame(e:Event=null):void {
			if(hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		private function onResize(e:Event = null):void {			
			shpBackground.graphics.clear();
			shpBackground.graphics.beginFill(0x000000,1);
			shpBackground.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			shpBackground.graphics.endFill();
		}
		
		private function setAsteroids():void {
			//remover todos os asteroids
			
			var numTotalRemover:Number = asteroids.length;
			for (var j:int = 0; j < numTotalRemover; j++) {
				removeAsteroid(0,true);
			}
			
			asteroids = [];
			
			for (var i:int; i < totalAsteroids; i++) {
				var newAsteroid:BigAsteroid = new BigAsteroid();
				asteroids.push(newAsteroid);
				sortValues(newAsteroid);
				addChild(newAsteroid);
			}
			
		}
		
		private function onEnterFrame(e:Event):void {
			allShips.update();
			shotControl.update();
			collisionControl.checkCollisions();
			connectionHandler.sendYourData();
		}
		
		
		private function removeAsteroid(pIndice:Number, isEnd:Boolean = false):void {
			var asteroid:Asteroid = asteroids[pIndice] as Asteroid;
			
			asteroids.splice(pIndice,1);
			
			removeChild(asteroid);
			
			if (asteroid is BigAsteroid) {
				if (!isEnd) {
					//cria 2 novos asteroids
					for (var i:int = 0; i < 2; i++) {
						var newAsteroid:SmallAsteroid = new SmallAsteroid();
						newAsteroid.x = asteroid.x;
						newAsteroid.y = asteroid.y;
						
						newAsteroid.vx = Math.random() * 2.5 - 1.5;
						newAsteroid.vy = Math.random() * 2.5 - 1.5;
						
						addChild(newAsteroid);
						
						asteroids.push(newAsteroid);
					}
				}
			}
		}
		
		private function controlAsteroids():void {
			for (var i:int; i < asteroids.length; i++) {
				var asteroid:Asteroid = asteroids[i] as Asteroid;
				
				asteroid.x += asteroid.vx;
				asteroid.y += asteroid.vy;
				
				var left:Number = 0;
				var right:Number = stage.stageWidth;
				var top:Number = 0;
				var bottom:Number = stage.stageHeight;
				
				//left and right boundaries
				if(asteroid.x - asteroid.width/2 > right) {
					asteroid.x = left - asteroid.width/2;
				} else if (asteroid.x + asteroid.width/2 < left) {
					asteroid.x = right + asteroid.width/2;
				}
				
				//top and bottom boundaries
				if (asteroid.y - asteroid.height/2 > bottom) {
					asteroid.y = top - asteroid.height/2;
				} else if (asteroid.y < top - asteroid.height/2) {
					asteroid.y = bottom + asteroid.height/2;
				}
			}
		}
		
		private function sortValues(pAsteroid:Asteroid):void {
			pAsteroid.x = Math.random() * stage.stageWidth;
			pAsteroid.y = Math.random() * stage.stageHeight;
			
			while ((pAsteroid.x > (stage.stageWidth/2 - protectionRange) && pAsteroid.x < (stage.stageWidth/2 + protectionRange) && pAsteroid.y > (stage.stageHeight/2 - protectionRange) && pAsteroid.y < (stage.stageHeight/2 + protectionRange))) {
				pAsteroid.x = Math.random() * stage.stageWidth;
				pAsteroid.y = Math.random() * stage.stageHeight;
			}
			
			pAsteroid.vx = Math.random() * 4 - 2.5;
			pAsteroid.vy = Math.random() * 4 - 2.5;
		}
		
	}
}