package com.smlg;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.text.TextFieldAutoSize;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.Font;
import nme.Assets;
/**
 * ...
 * @author smlg
 */

class SmButton extends SmUIElement
{
	
	public function new(text:String="",width:Float, height:Float) {
		super(text);
		
		//Label
		label.x = width / 2-label.width/2;
		label.y = height / 2-label.height/2;
		//Shape
		graphics.lineStyle(1, 0xf0f0f0);
		graphics.beginFill(0xffffff,1);
		graphics.drawRect( x, y,width,height);//Manage carefully, if one changes the x or y position, the complete sprite changes its coordinates behavior.
	}

}