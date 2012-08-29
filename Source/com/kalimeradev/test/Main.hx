package com.kalimeradev.test;

import com.kalimeradev.test.states.MenuState;
import com.kalimeradev.test.states.PlayState;
import com.kalimeradev.test.states.TestState;
import com.smlg.SmGame;
import com.smlg.SmState;
import com.smlg.SmButton;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import com.smlg.SmH;
import nme.display.FPS;
/**
 * ...
 * @author smlg
 */

class Main extends Sprite 
{
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end

	}

	private function init(e) 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		initialize();		
		////Screen
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 320;
		var ratioY:Float = stageHeight / 240;
		var ratio:Float = Math.min(ratioX, ratioY);
		////Game
		var game:SmGame= SmH.createGame(stageWidth,stageHeight,TestState);
		addChild(game);
		////FPS
		/*var fps:FPS = new FPS();
		addChild(fps);
		fps.x = 20;
		fps.y = 20;
		fps.textColor = 0xffffff;*/
		////
		//
		var cross:Sprite = new Sprite();
		cross.graphics.lineStyle(1, 0xf0f0f0);
		cross.graphics.moveTo(0,0);
		cross.graphics.lineTo(SmH.width, SmH.height);
		cross.graphics.moveTo(SmH.width,0);
		cross.graphics.lineTo(0, SmH.height);
		cross.graphics.moveTo(0,SmH.height/2);
		cross.graphics.lineTo(SmH.width, SmH.height/2);
		cross.graphics.moveTo(SmH.width/2,0);
		cross.graphics.lineTo(SmH.width/2, SmH.height);
		game.addChild(cross);
		//
	}
	
	static public function main() 
	{
		Lib.current.addChild(new Main());
	}
	
	private function initialize():Void 
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	}

}
