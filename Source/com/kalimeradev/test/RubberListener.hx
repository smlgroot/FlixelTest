package com.kalimeradev.test;
//
import com.smlg.SmGame;
//
import box2D.collision.B2AABB;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
//

//
import com.smlg.SmH;
class RubberListener extends B2ContactListener
{
	private var listener:Array<Int>->Void;
	private var id:Int;
	
	public function new(listener:Array<Int>->Void) {
		super();
		this.listener = listener;
	}
	override public function beginContact(contact:B2Contact):Void {
		var bodyEdge:B2Body = null;
		var bodyL:B2Body = null;
		var res:Bool=false ;
		var bodies:Array<B2Body> = findBodies(contact.getFixtureA().getBody(), contact.getFixtureB().getBody());
		if(bodies!=null && bodies.length>=2){
			bodyL = bodies.pop();
			bodyEdge = bodies.pop();

			//res = testXPosLessThan(bodyEdge, bodyL);
			//if(res==true){
				var userData = bodyEdge.getUserData();
				userData[2] = true;
				bodyEdge.setUserData(userData);
				this.listener(bodyEdge.getUserData());
			//}
		}
	}

	override public function endContact(contact:B2Contact) {
		var bodyEdge:B2Body = null;
		var bodyL:B2Body = null;
		var res:Bool=false ;
		
		var bodies = findBodies(contact.getFixtureA().getBody(), contact.getFixtureB().getBody());
		if(bodies!=null && bodies.length>=2){
			bodyL = bodies.pop();
			bodyEdge = bodies.pop();

			//res = testXPosLessThan(bodyL,bodyEdge);

			var userData = bodyEdge.getUserData();
			userData[2] = false;
			bodyEdge.setUserData(userData);
			this.listener(bodyEdge.getUserData());

		}
	}
	private function findBodies(bodyA:B2Body, bodyB:B2Body):Array<B2Body> {
		var res:Array<B2Body> = new Array<B2Body>();
		if (bodyA.getUserData()!=null) {		
			res.push(bodyA);
			res.push(bodyB);
			//trace("bodyA");
		}else if (bodyB.getUserData()!=null) {		
			res.push(bodyB);
			res.push(bodyA);
			//trace("bodyB");
		}
		return res;
	}
	private function testXPosLessThan(bodyA:B2Body,bodyB:B2Body):Bool {
		var res:Bool = false;
		var xA:Float = bodyA.getPosition().x / SmGame.PHYSICS_SCALE;
		var yA:Float = bodyA.getPosition().y / SmGame.PHYSICS_SCALE;
		var xB:Float = bodyB.getPosition().x / SmGame.PHYSICS_SCALE;
		var yB:Float = bodyB.getPosition().y / SmGame.PHYSICS_SCALE ;

		if (xA < xB) {
			res = true;
		}else {
			res = false;
		}
		return res;
	}
}