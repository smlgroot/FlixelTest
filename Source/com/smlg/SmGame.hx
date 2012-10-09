package com.smlg;
//
import com.kalimeradev.test.RubberListener;
import com.kalimeradev.test.states.MenuState;
import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.events.MouseEvent;
//
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.collision.B2AABB;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2MouseJoint;
import box2D.dynamics.joints.B2MouseJointDef;
import box2D.collision.shapes.B2EdgeShape;
import box2D.dynamics.joints.B2Joint;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.joints.B2PrismaticJoint;
import box2D.dynamics.joints.B2PrismaticJointDef;
import box2D.dynamics.B2World;
//
/**
 * ...
 * @author smlg
 */

class SmGame extends Sprite
{

	//
	public var currentstate:SmState;
	//
	public static var PHYSICS_SCALE:Float = 1 / 30;
	public static var World:B2World;
	private var PhysicsDebug:Sprite;
	//
	private static var mouseJoint:B2MouseJoint;
	public static var queriedBody:B2Body;
	public static var mouseXWorldPhys:Float;
	public static var mouseYWorldPhys:Float;
	//
	public function new(stageWidth:Float=0,stageHeight:Float=0) 
	{
		super();
		/////Screen
		SmH.width =stageWidth;
		SmH.height = stageHeight;
		//////BackGround
		var background:Sprite = new Sprite();
		/*background.x = 0;
		background.y = 0;
		background.width = SmH.width;
		background.height = SmH.height;*/
		background.graphics.beginFill(0xffffff, 1 );
		background.graphics.drawRect(0,0,SmH.width,SmH.height);
		addChild(background);

		//////
		World = new B2World (new B2Vec2 (0.0, 0.0), false);
	 
		PhysicsDebug = new Sprite ();
		this.addChild (PhysicsDebug);
			 
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit| B2DebugDraw.e_jointBit |B2DebugDraw.e_pairBit| B2DebugDraw.e_controllerBit|B2DebugDraw.e_aabbBit);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit | B2DebugDraw.e_centerOfMassBit);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit| B2DebugDraw.e_jointBit );
		//debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit);
		World.setDebugDraw(debugDraw);
		///////
	}
	public function createInitialState(initialState:Class<SmState>):Void {
		////State
		//Creating innitial state.
		currentstate = Type.createInstance(initialState, []);
		
		addEventListener (Event.ENTER_FRAME, onEnterFrame);

		addEventListener(MouseEvent.MOUSE_DOWN, currentstate.onMouseDown);
		addEventListener(MouseEvent.MOUSE_MOVE, currentstate.onMouseMove);
		addEventListener(MouseEvent.MOUSE_UP, currentstate.onMouseUp);
		
		addChild(currentstate);
		World.setContactListener(new RubberListener(currentstate.rubberListener));
	}
	private function onEnterFrame (e:Event):Void {
		
		/////////////
		if (mouseJoint != null) {
			var p2:B2Vec2=new B2Vec2(mouseXWorldPhys,mouseYWorldPhys);
			mouseJoint.setTarget(p2);
		}
		//////
		World.step (1 / 30, 10, 10);
		World.clearForces ();
		World.drawDebugData ();
		///////////
		currentstate.onEnterFrame(e);
	}


	//private function createL(posX:Float, posY:Float):B2Body {
		//var head:B2Body=createBox(posX, posY, 10,10, true,1,1);
		//var torse:B2Body = createCircle(posX, posY + 20, 15, true,-1,2);
		/*var legA:B2Body = createBox(posX - 10, posY + 45, 10, 20, true,1,1);
		var legB:B2Body = createBox(posX + 10, posY + 45, 10, 20, true,1,1);
		
		var headBottom:Float = head.getWorldCenter().y+(5*PHYSICS_SCALE);
		createRevoluteJoint(head,torse,new B2Vec2(head.getWorldCenter().x,headBottom));
		
		var torseBottomX:Float = torse.getWorldCenter().x-(7.5*PHYSICS_SCALE);
		var torseBottomY:Float = torse.getWorldCenter().y+(15*PHYSICS_SCALE);
		createRevoluteJoint(torse,legA,new B2Vec2(torseBottomX,torseBottomY));*/
		//return torse;
	//}

	/*private function createVerticalRubber(x1:Float, y1:Float,x2:Float, y2:Float,n:Int):Void {
		var attach = 0;
		var w:Float = 10;
		var h:Float = (Math.abs((x2-x1)-(y2-y1)))/n;

		var ancA=createBox(x1, y1, w, h+attach, false,2,-1);//AnchorA

		var Y:Float = y1+h ;
		var lastBody:B2Body = ancA;
		var currentBody:B2Body;
		for (i in 0 ... n) {
			var circleJointBody:B2Body = createCircle(x1, Y-(h/2), w, true,2,-1);
			currentBody = createBox(x1, Y, w, h + attach, true, 2, -1);
			var ancX:Float = currentBody.getWorldCenter().x;
			var ancY:Float = currentBody.getWorldCenter().y - ((h / 2)* PHYSICS_SCALE);
			createRevoluteJoint(lastBody, circleJointBody,new B2Vec2(ancX,ancY));
			createRevoluteJoint(circleJointBody, currentBody,new B2Vec2(ancX,ancY));
			lastBody = currentBody;
			Y = Y + h;
		}
		
		currentBody=createBox(x2, y2, w, h, false,2,-1);//AnchorB
		//createDistanceJoint(lastBody, currentBody, lastBody.getWorldCenter(), currentBody.getWorldCenter());
		createRevoluteJoint(lastBody, currentBody,currentBody.getWorldCenter());
	}*/


	public static function createRubber(x1:Float, y1:Float, x2:Float, y2:Float,id:Int):SmRubber{
		var body:B2Body = createEdge( x1,y1, x2, y2, true, id);
		
		var res:SmRubber = new SmRubber(body, new Rectangle(x1,y1,x2-x1,y2-y1));
		return res;
		
		////Visual Line
		/*showLine = false;
		line = new Sprite();
		addChild(line);*/
		////
	}

	private function createRevoluteJoint(bA:B2Body,bB:B2Body,anchor:B2Vec2):Void {
		var joint:B2RevoluteJointDef = new B2RevoluteJointDef();
		joint.initialize(bA, bB, anchor);
		//joint.localAnchorA.set(0,0);
		//joint.localAnchorB.set(0,1);
		joint.collideConnected = false;
		//joint.enableLimit = true;
		//joint.upperAngle = 0.78;
		//joint.lowerAngle = 1.5;
		//joint.referenceAngle= 0.78;
		//joint.dampingRatio = 5;
		//joint.frequencyHz = 60;
		
		//joint.localAnchorA.set(0, 1);
		//trace(joint.localAnchorB.x+"--"+joint.localAnchorB.y);
		//joint.enableMotor = true;
       // joint.motorSpeed = 0;
       // joint.enableLimit = true;
       // joint.lowerAngle = (45* 180 )/ Math.PI;
        //joint.upperAngle = (180* 180) / Math.PI;
		
		World.createJoint(joint);
	}
	
	private function createDistanceJoint(bA:B2Body,bB:B2Body,anchorA:B2Vec2, anchorB:B2Vec2):Void {
		var joint:B2DistanceJointDef = new B2DistanceJointDef();
		joint.initialize(bA, bB, anchorA, anchorB);
		//joint.localAnchorA.set(0,0);
		//joint.localAnchorB.set(0,1);
		joint.collideConnected = true;
		//joint.dampingRatio = 5;
		//joint.frequencyHz = 60;
		World.createJoint(joint);
	}
	
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool,maskBits:Int,categoryBits:Int):B2Body {
	 
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);

		if (dynamicBody) {
	 
			bodyDefinition.type = B2Body.b2_dynamicBody;
	 
		}
	 
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);

		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = .1;
		fixtureDefinition.friction = 0.1;
		fixtureDefinition.restitution = .5;
		
		if(maskBits>0){
			fixtureDefinition.filter.maskBits = maskBits;
		}
		if(categoryBits>0){
			fixtureDefinition.filter.categoryBits = categoryBits;
		}
		
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);

		return body;
	}
	
	public static function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool,maskBits:Int,categoryBits:Int):SmObject {
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		}
		
		var circle = new B2CircleShape (radius * PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		fixtureDefinition.restitution = .5;
		fixtureDefinition.density = .5;
		fixtureDefinition.friction = .1;
		
		if(maskBits>0){
			fixtureDefinition.filter.maskBits = maskBits;
		}
		if(categoryBits>0){
			fixtureDefinition.filter.categoryBits = categoryBits;
		}
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		//body.setBullet(true);
		
		var res:SmObject = new SmObject(body, radius);
		
		return res;
	}
	
	public static function createEdge( x1:Float,y1:Float,x2:Float,y2:Float,asSensor:Bool,userData:Int=-1):B2Body {
		////trace("createEdge");
		 
		var bodyDefinition = new B2BodyDef ();
		/*bodyDefinition.position.set (0,0);
		 
		x1 = x1 * PHYSICS_SCALE;
		y1 = y1 * PHYSICS_SCALE;
		
		x2 = x2 * PHYSICS_SCALE;
		y2 = y2 * PHYSICS_SCALE;*/
		
		
		var xA:Float =  x1;
		var yA:Float = y1;
		
		x1 = x1 * PHYSICS_SCALE;
		y1 = y1 * PHYSICS_SCALE;
		
		x2 = (x2-xA) *PHYSICS_SCALE;
		y2 = (y2-yA) * PHYSICS_SCALE;
		
		bodyDefinition.position.set (x1,y1);
		 
		
		

		var edge:B2PolygonShape = B2PolygonShape.asEdge(new B2Vec2(0,0),new B2Vec2(x2,y2));
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = edge;
		fixtureDefinition.density = 0;
		fixtureDefinition.friction = 0.3;
		if (asSensor) {
			fixtureDefinition.isSensor = true;
		}
	 
		var body:B2Body = World.createBody (bodyDefinition);
		if(userData>=0){
			body.setUserData(userData);
		}
		body.createFixture (fixtureDefinition);
		return body;
	}

	
	public static function createMouseJoint(e:MouseEvent):Void {
		GetBodyAtMouse(false, e);
		if (queriedBody != null) {
			///
			var mouseXWorldPhys:Float = e.stageX * PHYSICS_SCALE;
			var mouseYWorldPhys:Float = e.stageY * PHYSICS_SCALE;
			//
			var mouseJointDef:B2MouseJointDef=new B2MouseJointDef();
			mouseJointDef.bodyA=World.getGroundBody();
			mouseJointDef.bodyB=queriedBody;
			mouseJointDef.target.set(mouseXWorldPhys, mouseYWorldPhys);
			mouseJointDef.maxForce=500;
			//mouseJointDef.timeStep=m_timeStep;
			//mouseJointDef.frequencyHz =  30;
			mouseJoint= cast(World.createJoint(mouseJointDef),B2MouseJoint);
			//trace("createJoint");
		}
	}
	
	public static function GetBodyAtMouse(includeStatic:Bool=false,e:MouseEvent):B2Body {
		var mouseXWorldPhys:Float = (e.stageX)*PHYSICS_SCALE;
		var mouseYWorldPhys:Float = (e.stageY)*PHYSICS_SCALE;
		var mousePVec:B2Vec2 = new B2Vec2(mouseXWorldPhys, mouseYWorldPhys);
		
		var aabb:B2AABB = new B2AABB();
		aabb.lowerBound.set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
		aabb.upperBound.set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
		var k_maxCount:Int=10;
		//var shapes:Array = new Array();
		//var count:Int =
		World.queryAABB(callBackQueryAABB,aabb);
		var body:B2Body=null;
		/*for (var i:int = 0; i < count; ++i) {
			if (shapes[i].GetBody().IsStatic()==false||includeStatic) {
				var tShape:b2Shape=shapes[i] as b2Shape;
				var inside:Boolean=tShape.TestPoint(tShape.GetBody().GetXForm(),mousePVec);
				if (inside) {
					body=tShape.GetBody();
					break;
				}
			}
		}*/
		return body;
	}
	public static function callBackQueryAABB(fixture:B2Fixture):Bool {
		queriedBody = fixture.getBody();
		return true;
	}
	public static function destroyMouseJoint() {
		if (mouseJoint!=null) {
			World.destroyJoint(mouseJoint);
			mouseJoint = null;
			queriedBody = null;
			//trace("onMouseDown");
		}
	}
	public static function updateMouseJoint(e:MouseEvent) {
		mouseXWorldPhys = e.stageX * PHYSICS_SCALE;
		mouseYWorldPhys = e.stageY * PHYSICS_SCALE;
	}
	
}