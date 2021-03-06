package com.smlg;
import nme.text.Font;
import nme.Assets;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;
import nme.display.Sprite;
/**
 * ...
 * @author smlg
 */

class SmUIElement extends Sprite
{
	public var text:String;
	public var antialiasing:Bool;
	
	public var label:TextField ;
	public var font:Font;
	public var format:TextFormat;
	public var fontColor:Int;
	public var fontSize:Int;
	
	public function new(x:Float=0,y:Float=0,  text:String="") 
	{
		super();
		this.text=text;
		this.x=x;
		this.y=y;
		font = Assets.getFont ("assets/data/04B_03__.TTF");
		format = new TextFormat (font.fontName, 20, 0xf0f0f0);
		//
		label = new TextField();
		label.defaultTextFormat = format;
		label.selectable = false;
		label.embedFonts = true;
		label.autoSize = TextFieldAutoSize.LEFT;
		label.x = x;
		label.y = y;
		label.text =text;
		//nme.Lib.stage.addChild(label);
		this.addChild(label);
		//
		this.width = label.width;
		this.height = label.height;
	}

}