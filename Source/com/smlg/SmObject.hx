package com.smlg;
//
import box2D.dynamics.B2Body;
//
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author smlg
 */

class SmObject 
{
	public var rectangle(gR,null):Rectangle;
	public var body:B2Body;
	public var radius:Float;
	public var draw:Bool;
	
	public function new(body:B2Body, radius:Float) {
		this.body = body;
		this.radius = radius;
	}
	public function gR():Rectangle {
		rectangle = new Rectangle(body.getWorldCenter().x / SmGame.PHYSICS_SCALE, body.getWorldCenter().y / SmGame.PHYSICS_SCALE, radius * 2, radius * 2);
		return rectangle;		
	}

}