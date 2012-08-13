package com.smlg;

/**
 * ...
 * @author smlg
 */

class SmText extends SmUIElement
{

	
	public function new(x:Float=0,y:Float=0, width:Float=0, text:String="") {
		this.text=text;
		this.x=x;
		this.y=y;
		this.width=width;
		//this.fontSize=fontSize;
		//this.fontColor=fontColor;
		//this.antialiasing=antialiasing;
		super();
	}
	
}