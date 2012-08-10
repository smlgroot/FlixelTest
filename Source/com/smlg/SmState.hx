package com.smlg;
import nme.display.Graphics;

/**
 * ...
 * @author smlg
 */

class SmState 
{
	private var stateElements:Array<SmSprite>;
	public function new() 
	{
		stateElements = new Array<SmSprite>();
	}
	
	public function add(sprite:SmSprite):Void {
		stateElements.push(sprite);
	}

	public function create():Void {
	}
	
	public function update():Void {
	}
	public function draw(graphics:Graphics) {

		for (i in 0...stateElements.length) {
			stateElements[i].draw(graphics);
		}
	}
}