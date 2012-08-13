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
	//Label
	public var text:String;
	public var label:TextField;
	//Format
	var font:Font;
	var format:TextFormat;
	public function new(text:String="") 
	{
		super();
		//Format
		font = Assets.getFont ("assets/data/04B_03__.TTF");//TODO Change this for an app configuration (XML file)
		format = new TextFormat (font.fontName, 10, 0xf0f0f0);//TODO Change this for an app configuration (XML file)
		/////Label
		label = new TextField();
		label.selectable = false;
		label.autoSize = TextFieldAutoSize.LEFT;
		label.defaultTextFormat = format;
		label.text = text;
		
		addChild(label);
	}

}