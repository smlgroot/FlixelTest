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
		add(title1);
		//
		yesButton = new SmButton(SmH.width / 2, SmH.height / 2, "SI", onPlay);
		yesButton.x = yesButton.x - yesButton.width;
		yesButton.y = yesButton.y - yesButton.height/2;
		trace(yesButton.width);
		add(yesButton);	
		//
		noButton = new SmButton(SmH.width / 2, SmH.height / 2, "NO", onPlayB);
		//noButton.x = yesButton.x +yesButton.width;
		noButton.y = noButton.y - noButton.height/2;
		add(noButton);			
		/////
		trace("MenuState create");
	}
	
	override public function update():Void{
		super.update();
	}
	////Button CallBacks.
	private function onPlay():Void {
		
		var playstate:PlayState = new PlayState();
		playstate.titleText = "1";
		SmH.switchState(playstate);
	}
	private function onPlayB():Void {
		
		var playstate:PlayState = new PlayState();
		playstate.titleText = "2";
		SmH.switchState(playstate);
	}
}