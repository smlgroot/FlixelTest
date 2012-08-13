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

class SmButton extends Sprite
{
	public var onClick:Void->Void;
	//
	public var text:String;
	public var antialiasing:Bool;
	
	public var label:TextField ;
	public var font:Font;
	public var format:TextFormat;
	public var fontColor:Int;
	public var fontSize:Int;
	//
	public function new(x:Float = 0, y:Float = 0,  text:String = "", callBack:Dynamic->Void = null) {
		//super(x,y,text);
		super();
		font = Assets.getFont ("assets/data/04B_03__.TTF");
		format = new TextFormat (font.fontName, 20, 0xf0f0f0);
		label = new TextField();
		label.selectable = false;
		label.defaultTextFormat = format;
		label.autoSize = TextFieldAutoSize.LEFT;
		//label.x =x;
		//label.y = y;
		label.text = text;
		addChild(label);
		this.graphics.lineStyle(1, 0xf0f0f0);
		this.graphics.drawRect(200, 200, label.width, label.height);
		var rec:nme.geom.Rectangle = this.getBounds(this);
		this.graphics.beginFill(0xffffff, 0);
		this.graphics.drawRect(rec.x, rec.y, rec.width, rec.height);
		//
		//this.width=width;
		//this.height = height;
		this.addEventListener(MouseEvent.CLICK,callBack);
		//onClick = callBack;
	}
	/*override public function draw(g:Graphics):Void {
		g.lineStyle(1, 0xf0f0f0);
		g.drawRect(x, y, width, height);
	}*/
}