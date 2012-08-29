package com.smlg;


import com.eclecticdesignstudio.motion.Actuate;
/**
 * ...
 * @author smlg
 */

class SmH 
{
	public static var PHYSICS_SCALE:Float = 1 / 30;
	public static var game:SmGame;
	/////
	public static var height:Float;
	public static var width:Float;
	//
	
	public static function createGame(stageWidth:Float = 0, stageHeight:Float = 0, initialState:Class<SmState>):SmGame {
		game = new SmGame(stageWidth, stageHeight);
		game.createInitialState(initialState);
		return game;
	}
	public static function switchState(state:SmState):Void {
		//Hide current state then Replace it.
		Actuate.tween(game.currentstate, 1, {alpha:0} ).onComplete(replaceCurrentState,[state]);
	}
	public static function replaceCurrentState(state: SmState ) {
		game.removeChild(game.currentstate);
		game.addChild(state);
		game.currentstate = state;
		//state.alpha = 0;
		//Actuate.tween (state, 1, {alpha:1} );
	}
}