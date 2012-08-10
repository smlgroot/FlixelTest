package com.smlg;
import nme.display.Graphics;
import nme.display.Sprite;

/**
 * ...
 * @author smlg
 */

class SmState extends Sprite
{
	private var stateElements:Array<Sprite>;
	public function new() 
	{
		super();
		stateElements = new Array<Sprite>();

	}
	
	public function add(sprite:Sprite):Void {
		addChild(sprite);
		//stateElements.push(sprite);
	}

	public function create():Void {
	}
	
	public function update():Void {
	}
	/*public function draw(graphics:Graphics) {

		for (i in 0...stateElements.length) {
			//stateElements[i].draw(graphics);
		}
	}*/
}