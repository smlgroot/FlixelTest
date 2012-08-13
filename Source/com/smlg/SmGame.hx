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
	
	public function new(stageWidth:Float=0,stageHeight:Float=0,initialState:Class<SmState>) 
	{
		super();
		/////Screen
		SmH.width =stageWidth;
		SmH.height = stageHeight;
		////State
		//Creating innitial state.
		currentstate = Type.createInstance(initialState, []);
		//currentstate.create();
		addChild(currentstate);
		
		//var menuState:SmState = new MenuState();	
		//addChild(menuState);	

	}


}