package com.smlg;
import com.kalimeradev.test.states.MenuState;
import nme.display.Sprite;
import nme.events.Event;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
/**
 * ...
 * @author smlg
 */

class SmGame extends Sprite
{

	//
	public var currentstate:SmState;
	//
	
	///
	
	public function new(stageWidth:Float=0,stageHeight:Float=0) 
	{
		super();
		/////Screen
		SmH.width =stageWidth;
		SmH.height = stageHeight;
		//////BackGround
		var background:Sprite = new Sprite();
		/*background.x = 0;
		background.y = 0;
		background.width = SmH.width;
		background.height = SmH.height;*/
		background.graphics.beginFill(0xffffff, 1 );
		background.graphics.drawRect(0,0,SmH.width,SmH.height);
		addChild(background);
		
		//var menuState:SmState = new MenuState();	
		//addChild(menuState);	

	}
	public function createInitialState(initialState:Class<SmState>):Void {
		////State
		//Creating innitial state.
		currentstate = Type.createInstance(initialState, []);
		addChild(currentstate);
	}

}