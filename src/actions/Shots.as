package actions
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import assets.Bomb;
	import assets.EletricShot;
	import assets.Missele;
	import assets.NormalShot;
	import assets.Shot;
	
	import connection.ConnectionControl;
	
	import controllers.YourShipControl;

	public class Shots
	{
		
		private var shipControl:YourShipControl;
		
		public var sprInformation:Sprite = new Sprite();
		public var sprWeapon:Sprite = new Sprite();
		private var _currentWeaponId:Number = 0;
		
		private var shotTypes:Array;
		private var maxShots:Number = 3;
		private var numShotAtual:Number = -1;
		
		//array that stores the shottings in the screen
		public var currentShottingArray:Array=[];
		
		[Embed(source="../../img/shot-solo.png")]
		public var EletricAssetBitmap:Class;
		
		[Embed(source="../../img/missele-solo.png")]
		public var MisseleAssetBitmap:Class;
		
		[Embed(source="../../img/bomb-solo.png")]
		public var BombAssetBitmap:Class;
		
		public function Shots()
		{
		}
		
		public function setup():void {
			shotTypes = [];
			shotTypes.push({shotClass:NormalShot, 	maxShots:5});
			shotTypes.push({shotClass:EletricShot, 	maxShots:3});
			shotTypes.push({shotClass:Missele, 		maxShots:3});
			shotTypes.push({shotClass:Bomb, 		maxShots:5});
			
			currentShottingArray = [];
			
			//buildShots();
			buildShotInfo();
		}
		
		private function buildShots():void {
			for (var i:int = 0; i < shotTypes.length; i++) {
				var arrShots:Array = shotTypes[i].arrayShots;
				
				for (var j:int = 0; j < shotTypes[i].maxShots; j++) {
					var clsShot:Shot = new shotTypes[i].shotClass();
					var nameId:String = getQualifiedClassName(shotTypes[i].shotClass).split('::')[1];
					clsShot.id = nameId + "_" + String(j);
					arrShots.push(clsShot);
				}
			}
		}
		
		public function addShot(userID:String, data:Object = null):void {
			/*if (numShotAtual>=shotTypes[_currentWeaponId].maxShots-1) {
				numShotAtual = 0;
			} else {
				numShotAtual+=1;
			}
			
			currentShotArray = shotTypes[_currentWeaponId].arrayShots;
			
			var shot:Shot = currentShotArray[numShotAtual] as Shot;
			SpaceShip.Game.addChild(shot);
			shot.isShotting = true;
			shot.vx = 0;
			shot.vy = 0;
			shot.shot();
			
			var angle:Number = shipControl.ship.rotation * Math.PI/180;
			var newPoint:Point = shipControl.ship.localToGlobal(new Point(15,0));
			
			shot.x = newPoint.x;
			shot.y = newPoint.y;
			shot.angle = angle;
			shot.rotation = shipControl.ship.rotation;
			
			if (!checkShotInArray(shot.id)) {
				var className:String = getQualifiedClassName(shot).split('::')[1];
				currentShottingArray.push({shot:shot, type:className, x:shot.x, y:shot.y, rotation:shot.rotation});
			}*/
			
			
			var shot:Shot;
			var angle:Number;
			var newPoint:Point;
			
			if (userID == SpaceShip.Game.connectionHandler.myID) {
				//MEU TIRO
				shot = new shotTypes[_currentWeaponId].shotClass();
				shot.isShotting = true;
				shot.senderID = SpaceShip.Game.connectionHandler.myID;
				shot.vx = 0;
				shot.vy = 0;
				shot.shot();
				
				angle = SpaceShip.Game.allShips.you.ship.rotation * Math.PI/180;
				newPoint = SpaceShip.Game.allShips.you.ship.localToGlobal(new Point(15,0));
				
				shot.x = newPoint.x;
				shot.y = newPoint.y;
				shot.angle = angle;
				shot.rotation = SpaceShip.Game.allShips.you.ship.rotation;
				
				
				SpaceShip.Game.connectionHandler.sendShotData({	x:shot.x, 
																y:shot.y, 
																angle:shot.angle, 
																rotation:shot.rotation, 
																userID:SpaceShip.Game.connectionHandler.myID, 
																shotType:_currentWeaponId, 
																type:ConnectionControl.TYPE_SHOTS, 
																vyShip:SpaceShip.Game.allShips.you.ship.vy, 
																vxShip:SpaceShip.Game.allShips.you.ship.vx});
				
			} else {
				//TIRO DE USUARIO
				shot = new shotTypes[data.shotType].shotClass();
				shot.senderID = userID;
				shot.isShotting = true;
				shot.vx = 0;
				shot.vy = 0;
				shot.vxShip = data.vxShip;
				shot.vyShip = data.vyShip;
				shot.shot();
				
				shot.x = data.x;
				shot.y = data.y;
				shot.angle = data.angle;
				shot.rotation = data.rotation;
			}
			
			//Adiciona na array
			currentShottingArray.push(shot);
			
			
			//Adiciona no stage
			SpaceShip.Game.addChild(shot);
		}
		
		public function update():void {
			var left:Number = 0;
			var right:Number = SpaceShip.Game.stage.stageWidth;
			var top:Number = 0;
			var bottom:Number = SpaceShip.Game.stage.stageHeight;
			
			
			for (var i:int; i < currentShottingArray.length; i++) {
				var shot:Shot = currentShottingArray[i] as Shot;
				
				if (shot.isShotting) {
					
					if (shot.shotType == Shot.TYPE_TRAVALER) {
						var angle:Number = shot.angle;
						
						var ax:Number = Math.cos(angle) * shot.thrust;
						var ay:Number = Math.sin(angle) * shot.thrust;
						
						shot.vx += ax;
						shot.vy += ay;
						
						if (shot.senderID == SpaceShip.Game.connectionHandler.myID) {
							shot.x += shot.vx + SpaceShip.Game.allShips.you.ship.vx;
							shot.y += shot.vy + SpaceShip.Game.allShips.you.ship.vy;
						} else {
							shot.x += shot.vx + shot.vxShip;
							shot.y += shot.vy + shot.vyShip;
						}
						
						
					} else {
						//do nothing, the shot stay static
					}
					
					//currentShottingArray[i].x = shot.x;
					//currentShottingArray[i].y = shot.y;
					
					if(shot.x - shot.width/2 > right) {
						removeShot(i);
					} else if (shot.x + shot.width/2 < left) {
						removeShot(i);
					}
					
					//top and bottom boundaries
					if (shot.y - shot.height/2 > bottom) {
						removeShot(i);
					} else if (shot.y < top - shot.height/2) {
						removeShot(i);
					}
				}
			}
		}
		
		
		/**
		 * 
		 * TODO
		 * 
		 */
		public function removeAllShotsFromUser(userID:String):void {
			
		}
		
		public function removeShot(pIndice:Number):void {
			if (currentShottingArray[pIndice] != null) {
				currentShottingArray[pIndice].isShotting = false;
				currentShottingArray[pIndice].removeShot();
				SpaceShip.Game.removeChild(currentShottingArray[pIndice]);
				
				currentShottingArray.splice(pIndice,1);	
			}
		}
		
		
		/**
		 * SHOT INFO
		 */
		public function buildShotInfo():void {
			sprInformation.addChild(sprWeapon);
			SpaceShip.Game.addChild(sprInformation);
			
			//weapon change graphics
			var sprShot:Sprite = new Sprite();
			var bmpEletric:Bitmap = new EletricAssetBitmap();
			var bmpMissele:Bitmap = new MisseleAssetBitmap();
			var bmpBomb:Bitmap = new BombAssetBitmap();
			
			sprShot.graphics.beginFill(0xffffff,1);
			sprShot.graphics.drawCircle(-0.5,-0.5,1);
			sprShot.graphics.endFill();
			
			bmpMissele.rotation = 270;
			bmpMissele.y = (bmpMissele.height/2)*2 + 5;
			bmpMissele.x = 80 - bmpMissele.width;
			
			bmpEletric.y = (bmpEletric.height/2) + 4;
			bmpEletric.x = 50 - bmpEletric.width + 3;
			
			bmpBomb.y = 15 - (bmpBomb.height/2);
			bmpBomb.x = 110 - bmpBomb.width + 3;
			
			sprShot.x = 16.5;
			sprShot.y = 16.5;
			
			sprWeapon.addChild(sprShot);
			sprWeapon.addChild(bmpEletric);
			sprWeapon.addChild(bmpMissele);
			sprWeapon.addChild(bmpBomb);
			
			updateShotInfo();
		}
		
		public function updateShotInfo():void {
			sprWeapon.graphics.clear();
			
			var numX:Number = 0;
			for (var i:int = 0; i < shotTypes.length; i++) {
				if (i != currentWeaponId) {
					sprWeapon.graphics.lineStyle(1,0xffffff,1);
				}
				
				sprWeapon.graphics.drawRect(numX,0,30,30);
				
				numX += 30;
			}
			
			sprWeapon.graphics.lineStyle(1,0xff0000,1);
			sprWeapon.graphics.drawRect(30*currentWeaponId,0,30,30);
			
			sprWeapon.graphics.endFill();
		}
		
		public function set currentWeaponId(pNumber:Number):void {
			_currentWeaponId = pNumber;
			updateShotInfo();
		}
		
		public function get currentWeaponId():Number {
			return _currentWeaponId;
		}
	}
}