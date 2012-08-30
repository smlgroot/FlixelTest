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

class SmRubber extends SmObject
{

	public var rect:Rectangle;

	
	public function new(body:B2Body, rect:Rectangle) {
		super(body,0);
		this.rect = rect;
	}


}