package com.smlg;

/**
 * ...
 * @author smlg
 */

class SmObject 
{

	public var x(getX,setX):Float;
	public var y(getY,setY):Float;
	public var width:Float;
	public var height:Float;

	public function new() {
	
	}
	
	//Getters/Setters
	public function getX():Float {
		return this.x;
	}
	
	public function setX(x:Float):Float{
		this.x = x;
		return this.x;
	}
	public function getY():Float {
		return this.y;
	}
	
	public function setY(y:Float):Float{
		this.y = y;
		return this.y;
	}
}