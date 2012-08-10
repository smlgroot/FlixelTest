package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */
import com.smlg.SmState;
import com.smlg.SmH;
import com.smlg.SmText;
import com.smlg.SmButton;
import nme.display.Bitmap;
import nme.Assets;
import nme.geom.Point;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.display.Sprite;
import feffects.Tween;
import feffects.easing.Quad;

class MenuState extends SmState
{
	public var title1:SmText;
	public var yesButton:SmButton;
	public var noButton:SmButton;
	
	override public function create():Void {
		title1 = new SmText(0,0, SmH.width, "??");
		title1.fontSize = 12;
		title1.fontColor = 0x3a5c39;
		title1.antialiasing = true;
		//title1.velocity.x = -SmH.width;
		title1.x = SmH.width/2 -title1.width/2;
		title1.y =SmH.height /2 -title1.height*2;
		addChild(title1);
		//
		yesButton = new SmButton(SmH.width / 2, SmH.height / 2, "SI", onPlay);
		yesButton.x = yesButton.x - yesButton.width;
		yesButton.y = yesButton.y - yesButton.height / 2;
		this.addChild(yesButton);	
		//
		noButton = new SmButton(SmH.width / 2, SmH.height / 2, "NO", onPlayB);
		//noButton.x = yesButton.x +yesButton.width;
		noButton.y = noButton.y - noButton.height / 2;
		this.addChild(noButton);			
		/////
		//
		
	}
	
	override public function update():Void{
		super.update();
	}
	////Button CallBacks.
	private function onPlay(e):Void {
		trace("onPlay()");
		/*yesButton.x = 50;
		yesButton.y = 50;*/
		var tween:Tween = new Tween(yesButton.x, SmH.width, 10000, Quad.easeOut);
		tween.onUpdate(move);
		tween.start();
		/*var playstate:PlayState = new PlayState();
		playstate.titleText = "1";
		SmH.switchState(playstate);*/
	}
	private function onPlayB(e):Void {
		trace("onPlayB()");
		/*var playstate:PlayState = new PlayState();
		playstate.titleText = "2";
		SmH.switchState(playstate);*/
	}
	private function move(e):Void {
		yesButton.x = e;
	}
}