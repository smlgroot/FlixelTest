package com.smlg;
import nme.display.Graphics;

/**
 * ...
 * @author smlg
 */

class SmButton extends SmUIElement
{
	public var onClick:Void->Void;

	public function new(x:Float=0,y:Float=0,  text:String="",callBack:Void->Void=null) {
		//
		//this.width=width;
		//this.height = height;
		onClick = callBack;
		super(x,y,text);
	}
	override public function draw(g:Graphics):Void {
		g.lineStyle(1, 0xf0f0f0);
		g.drawRect(x, y, width, height);
	}
}