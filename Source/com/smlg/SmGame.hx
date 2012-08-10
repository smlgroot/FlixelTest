package com.smlg;
import nme.display.Sprite;
import nme.events.Event;
/**
 * ...
 * @author smlg
 */

class SmGame extends Sprite
{
//
public var currentstate:SmState;
//
	public var forceDebugger:Bool;

	public function new(sizeX:Float, sizeY:Float,initialState:Class<SmState>, zoom:Float,frameRate:Int=60 ) 
	{
		super();
		SmH.width = sizeX*zoom;
		SmH.height = sizeY*zoom;
		//Creating innitial state.
		currentstate=Type.createInstance(initialState, []);
		currentstate.create();
		//
		//
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	private function this_onEnterFrame (event:Event):Void {
		//Drawing phase.
		draw();
		//update phase
		//update();
	}
	public function draw():Void {
		currentstate.draw(this.graphics);
	}
	public function update():Void {
		currentstate.update();
	}
}