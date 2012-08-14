package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */
import com.smlg.SmGame;
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
import nme.text.TextFormat;
import nme.text.Font;
import nme.Assets;
import nme.events.MouseEvent;
import feffects.Tween;
import feffects.easing.Quad;
///Actuate
import com.eclecticdesignstudio.motion.Actuate;

class MenuState extends SmState
{
	public var yesButton:SmButton;
	public var noButton:SmButton;
	
	public function new() {
		super();
		//Texts
		var mainTitle:SmText = new SmText("Main");
		mainTitle.x = SmH.width / 2-mainTitle.width/2;
		mainTitle.y = 10;
		addChild(mainTitle);
		////Buttons
		yesButton = new SmButton("YES",50,50);
		yesButton.x = SmH.width/2 - yesButton.width;
		yesButton.y = SmH.height/2 - yesButton.height / 2;
		yesButton.addEventListener(MouseEvent.CLICK, onPlay);
		addChild(yesButton);
		noButton = new SmButton("NO",50,50);
		noButton.x = SmH.width/2 ;
		noButton.y = SmH.height/2 - noButton.height / 2;
		noButton.addEventListener(MouseEvent.CLICK, onPlayB);
		addChild(noButton);
	}

	private function onPlay(e):Void {
		trace("onPlay()");
		//yesButton.x = 50;
		//yesButton.y = 50;	
		yesButton.width = 70;
		yesButton.height = 70;
		/*var tween:Tween = new Tween(0, SmH.width/2-yesButton.width, 1000, Quad.easeOut);
		tween.onUpdate(move);
		tween.start();*/
		var playstate:PlayState = new PlayState();
		SmH.switchState(playstate);
	}

	private function move(e):Void {
		yesButton.x = e;
	}

	private function onPlayB(e):Void {
		trace("onPlayB()");
		/*var tween:Tween = new Tween(SmH.width,SmH.width/2, 1000, Quad.easeOut);
		tween.onUpdate(moveB);
		tween.start();*/
		
		///
		
		//Actuate.transform (noButton, 1).color (0xFF0000, 0.5);
		Actuate.tween (noButton, 5, { x: 200 ,alpha:0} ).repeat(5);

	}
	private function moveB(e):Void {
		noButton.x = e;
	}
}