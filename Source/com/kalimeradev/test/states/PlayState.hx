package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */
import com.smlg.SmState;
import com.smlg.SmH;
import com.smlg.SmAssets;
import com.smlg.SmText;
import com.smlg.SmButton;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import feffects.Tween;
import feffects.easing.Quad;

class PlayState extends SmState
{
	public var titleResponse:SmText;
	public var titleText:String;
	
	override public function create():Void {
		SmH.bgColor = 0xff0000;

		
		titleResponse = new SmText(0,SmH.height/2, SmH.width, titleText);
		titleResponse.fontSize = 12;
		titleResponse.fontColor = 0x3a5c39;
		titleResponse.antialiasing = true;
		//titleResponse.velocity.x = 10;
		titleResponse.x = SmH.width/2 -titleResponse.width/2;
		titleResponse.y =SmH.height /2 -titleResponse.height*2;
		add(titleResponse);
		////////


		////////
		var tweenA = new Tween( SmH.width,0, 1000, Quad.easeOut);
		tweenA.onUpdate(moveA);
       tweenA.start();
		trace("PlayState create");
	}
	
	override public function update():Void{
		super.update();
	}
	////Button CallBacks.
	
	////Tween CallBacks.
	function moveA( e : Float )
    {
		titleResponse.x = e;
    }	
}