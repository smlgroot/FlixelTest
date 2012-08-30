package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */


import com.smlg.SmGame;
import com.smlg.SmObject;
import com.smlg.SmState;
import com.smlg.SmH;
import com.smlg.SmAssets;
import com.smlg.SmText;
import com.smlg.SmButton;
import com.smlg.SmRubber;

/////
//
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
//
import feffects.Tween;
import feffects.easing.Quad;
//
/////////
class TestState extends SmState
{
	
	//////////////////
	//public var lA:B2Body;
	
	var line:Sprite;
	///////////////////
	
	private var rubbers:Array<SmRubber>;
	var lA:SmObject;
	
	public function new() {
		super();
		//////////////
		initialize ();
		construct ();
		///////////////
	}
	private function initialize ():Void {
		
		rubbers = new Array<SmRubber>();

	}
	private function construct ():Void {
		
		createWalls();
		
		createRingWalls(200,200,400,400);
		
		lA=SmGame.createCircle(250,250,20,true,0,0);
		
		//lA=createL(150,170);

	 
	}
	
	override public function onEnterFrame (e:Event):Void {
		
		/////////
		if (rubbers.length > 0) {
			graphics.clear();
			if (rubbers[0].draw == true) {
				var lAX:Float = (lA.rectangle.x-lA.rectangle.width/2);
				var lAY:Float = (lA.rectangle.y);

				var rbX1:Float = (rubbers[0].rect.x);
				var rbY1:Float = (rubbers[0].rect.y);
				var rbX2:Float = (rubbers[0].rect.x+rubbers[0].rect.width);
				var rbY2:Float = (rubbers[0].rect.y+rubbers[0].rect.height);
				
				graphics.clear();

				graphics.lineStyle(2, 0xf0f0f0);
				
				
				graphics.moveTo(rbX1,rbY1);
				graphics.lineTo(lAX,lAY);
				
				graphics.moveTo(rbX1,rbY2);
				graphics.lineTo(lAX, lAY);
			}
		}
		////
	}
	
	override public function onMouseDown(e:MouseEvent):Void {
		SmGame.createMouseJoint(e);		
	}
	override public function onMouseMove(e:MouseEvent):Void {
		SmGame.updateMouseJoint(e);
	}
	override public function onMouseUp(e:MouseEvent):Void {
		SmGame.destroyMouseJoint();
	}
	override public function rubberListener(id:Int,draw:Bool):Void {
		rubbers[id].draw=draw;
	}
	
	public function createWalls():Void {
		////trace("createWalls");
		 
		SmGame.createEdge(0, 0, 0,SmH.height,false);//Left.
		SmGame.createEdge(0, 0, SmH.width, 0, false);//Top.
		SmGame.createEdge(SmH.width, 0, SmH.width, SmH.height, false);//Right.
		SmGame.createEdge(SmH.width, SmH.height, 0, SmH.height, false);//Bottom.

	}
	public function createRingWalls(x:Float,y:Float,w:Float,h:Float):Void {
		////trace("createRingWalls");
		
		var cornerWidth:Float = w * .10;
		var cornerHeight:Float = h * .10;
		
		SmGame.createEdge( x, y+cornerHeight, x, h-cornerHeight, false);//Left.
		SmGame.createEdge( x, y+cornerHeight,x+cornerWidth, y+cornerHeight, false);//LeftTopCorner.
		SmGame.createEdge( x, h - cornerHeight, x + cornerWidth, h - cornerHeight, false);//LeftBottomCorner.
		var tempRubber:SmRubber= SmGame.createRubber(x + cornerWidth, y + cornerHeight, x + cornerWidth, h - cornerHeight,0);//LeftRubber.
		rubbers.push(tempRubber);
		
		
		SmGame.createEdge( x + cornerWidth, y, w - cornerWidth, y, false);//Top.
		SmGame.createEdge( x + cornerWidth, y, x + cornerWidth,y+cornerHeight, false);//TopLeftCorner.
		SmGame.createEdge( w - cornerWidth, y, w - cornerWidth,y+cornerHeight, false);//TopRightBottomCorner.
		
		
		
		SmGame.createEdge( w, y + cornerHeight, w, h - cornerHeight, false);//Right.
		SmGame.createEdge( w, y + cornerHeight, w-cornerWidth, y + cornerHeight, false);//RightTopCorner.
		SmGame.createEdge( w, h - cornerHeight, w-cornerWidth, h - cornerHeight, false);//RightBottomCorner.
		
		
		
		SmGame.createEdge( w-cornerWidth, h, x+cornerWidth, h, false);//Bottom.
		SmGame.createEdge( w-cornerWidth, h, w-cornerWidth, h-cornerHeight, false);//BottomRightCorner.
		SmGame.createEdge( x+cornerWidth, h-cornerHeight, x+cornerWidth, h, false);//BottomLeftCorner.
	}
}