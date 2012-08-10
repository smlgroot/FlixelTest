package com.kalimeradev.test;

/**
 * ...
 * @author smlg
 */
import com.smlg.SmGame;
import nme.Lib;
import com.kalimeradev.test.states.MenuState;

class Game  extends SmGame
{

	public function new() 
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		var ratioX:Float = stageWidth / 320;
		var ratioY:Float = stageHeight / 240;
		var ratio:Float = Math.min(ratioX, ratioY);
		super(Math.floor(stageWidth / ratio), Math.floor(stageHeight / ratio), MenuState, ratio, 60);

		forceDebugger = true;
	}
	
}