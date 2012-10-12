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
	public var rect:Rectangle;
	public var draw:Bool;
	//
	public static var PROPERTY_USER_DATA:Int=1;
	public static var PROPERTY_DENSITY:Int=2;
	public static var PROPERTY_FRICTION:Int=3;
	public static var PROPERTY_RESTITUTION:Int=4;
	public static var PROPERTY_SENSOR:Int=5;
	//
	public static var OBJECT_TYPE_CIRCLE:Int = 1;
	public static var OBJECT_TYPE_BOX:Int = 2;
	public static var OBJECT_TYPE_TORSE:Int = 3;
	public static var OBJECT_TYPE_FOOT:Int = 4;
	public static var OBJECT_TYPE_ARM:Int = 5;
	public static var OBJECT_TYPE_RUBBER:Int = 6;
	//
	public static var RUBBER_POS_LEFT:Int = 1;
	public static var RUBBER_POS_TOP:Int = 2;
	public static var RUBBER_POS_RIGHT:Int = 3;
	public static var RUBBER_POS_BOTTOM:Int = 4;
	//
	public function new(body:B2Body, rect:Rectangle) {
		this.body = body;
		this.rect = rect;
	}
	public function gR():Rectangle {
		rectangle = new Rectangle(body.getWorldCenter().x / SmGame.PHYSICS_SCALE, body.getWorldCenter().y / SmGame.PHYSICS_SCALE, rect.width, rect.height);
		return rectangle;		
	}

	
	public function setProperty(name:Int, value:Dynamic ) {
		switch(name) {
		case PROPERTY_USER_DATA:
			this.body.setUserData(value);
		case PROPERTY_DENSITY:
			if(!Math.isNaN(value))this.body.getFixtureList().setDensity(value);
		case PROPERTY_FRICTION:
			if(!Math.isNaN(value))this.body.getFixtureList().setFriction(value);
		case PROPERTY_RESTITUTION:
			if(!Math.isNaN(value))this.body.getFixtureList().setRestitution(value);
		case PROPERTY_SENSOR:
			this.body.getFixtureList().setSensor(value);	
		}
	}
}