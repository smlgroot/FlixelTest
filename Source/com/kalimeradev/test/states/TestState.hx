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
	
	private var rubbers:Array<SmObject>;
	var lA:SmObject;
	
	public function new() {
		super();
		//////////////
		initialize ();
		construct ();
		///////////////
	}
	private function initialize ():Void {
		
		rubbers = new Array<SmObject>();

	}
	private function construct ():Void {
		
		createWalls();
		createRing(SmH.width/2-100,SmH.height/2-100,200,200);//posX,posY,width,height
		
		lA = SmGame.createCircle((SmH.width / 2), (SmH.height / 2), 10, true);
		lA.setProperty(SmObject.PROPERTY_USER_DATA, [SmObject.OBJECT_TYPE_CIRCLE]);
		//lA.setProperty(SmObject.PROPERTY_RESTITUTION,5*SmGame.PHYSICS_SCALE);
		//
		//
		//SmGame.createL((SmH.width/2),(SmH.height/2),50,50);

	 
	}
	
	override public function onEnterFrame (e:Event):Void {
		
		/////////
		if (rubbers.length > 0) {
			graphics.clear();
			for (i in 0...rubbers.length ) {
				if (rubbers[i].draw == true) {
					var lAX:Float = (lA.rectangle.x);
					var lAY:Float = (lA.rectangle.y);

					var rbX1:Float = (rubbers[i].rect.x);
					var rbY1:Float = (rubbers[i].rect.y);
					var rbX2:Float = (rubbers[i].rect.right);
					var rbY2:Float = (rubbers[i].rect.bottom);
					
					graphics.clear();

					graphics.lineStyle(2, 0xfff0f0);
					
					
					graphics.moveTo(rbX1,rbY1);
					graphics.lineTo(lAX,lAY);
					
					graphics.moveTo(rbX2,rbY2);
					graphics.lineTo(lAX, lAY);
				}
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
	override public function rubberListener(userData:Array<Int>):Void {
		var id:Int = userData[0];
		var pos:Int = userData[1];
		var state:Int = userData[2];
		
		rubbers[id].draw= if(state==0)false else true ;
	}
	
	public function createWalls():Void {
		////trace("createWalls");
		 
		SmGame.createEdge(0, 0, 0,SmH.height);//Left.
		SmGame.createEdge(0, 0, SmH.width, 0);//Top.
		SmGame.createEdge(SmH.width, 0, SmH.width, SmH.height);//Right.
		SmGame.createEdge(SmH.width, SmH.height, 0, SmH.height);//Bottom.

	}
	public function createRing(x:Float,y:Float,w:Float,h:Float):Void {
		////trace("createRingWalls");
		
		var cornerWidth:Float = w * .10;
		var cornerHeight:Float = h * .10;
		
		SmGame.createEdge( x, y+cornerHeight, x, y+h-cornerHeight);//Left.
		SmGame.createEdge( x, y+cornerHeight,x+cornerWidth, y+cornerHeight);//LeftTopCorner.
		SmGame.createEdge( x, y+h - cornerHeight, x + cornerWidth, y+h - cornerHeight);//LeftBottomCorner.
		var tempRubber:SmObject= SmGame.createRubber(x + cornerWidth, y + cornerHeight, x + cornerWidth, y+h - cornerHeight,SmObject.RUBBER_POS_LEFT);//LeftRubber.
		rubbers.push(tempRubber);
		
		
		SmGame.createEdge( x + cornerWidth, y, x+w - cornerWidth, y);//Top.
		SmGame.createEdge( x + cornerWidth, y, x + cornerWidth,y+cornerHeight);//TopLeftCorner.
		SmGame.createEdge( x + w - cornerWidth, y, x + w - cornerWidth, y + cornerHeight);//TopRightBottomCorner.
		tempRubber= SmGame.createRubber(x + cornerWidth, y + cornerHeight, x +w- cornerWidth, y+ cornerHeight,SmObject.RUBBER_POS_TOP);//TopRubber.
		rubbers.push(tempRubber);
		
		
		
		SmGame.createEdge( x+w, y + cornerHeight, x+w, y+h - cornerHeight);//Right.
		SmGame.createEdge( x+w, y + cornerHeight, x+w-cornerWidth, y + cornerHeight);//RightTopCorner.
		SmGame.createEdge( x + w, y + h - cornerHeight, x + w - cornerWidth, y + h - cornerHeight);//RightBottomCorner.
		tempRubber= SmGame.createRubber(x +w- cornerWidth, y + cornerHeight, x +w- cornerWidth, y+h- cornerHeight,SmObject.RUBBER_POS_RIGHT);//RightRubber.
		rubbers.push(tempRubber);
		
		
		
		SmGame.createEdge( x+w-cornerWidth, y+h, x+cornerWidth, y+h);//Bottom.
		SmGame.createEdge( x+w-cornerWidth, y+h, x+w-cornerWidth, y+h-cornerHeight);//BottomRightCorner.
		SmGame.createEdge( x+cornerWidth, y+h-cornerHeight, x+cornerWidth, y+h);//BottomLeftCorner.
		tempRubber= SmGame.createRubber(x +w- cornerWidth, y +h- cornerHeight, x +cornerWidth, y+h- cornerHeight,SmObject.RUBBER_POS_BOTTOM);//BottomRubber.
		rubbers.push(tempRubber);
	}
}