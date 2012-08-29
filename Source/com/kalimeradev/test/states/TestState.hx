package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */
import box2D.collision.shapes.B2EdgeShape;
import box2D.dynamics.joints.B2Joint;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.joints.B2PrismaticJoint;
import box2D.dynamics.joints.B2PrismaticJointDef;
import com.smlg.SmState;
import com.smlg.SmH;
import com.smlg.SmAssets;
import com.smlg.SmText;
import com.smlg.SmButton;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.Assets;
import feffects.Tween;
import feffects.easing.Quad;
import nme.events.MouseEvent;
///////////
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Lib;
import box2D.collision.B2AABB;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2MouseJoint;
import box2D.dynamics.joints.B2MouseJointDef;
///////////
import com.kalimeradev.test.MyContactListener;
class TestState extends SmState
{
	
	//////////////////
	private static var PHYSICS_SCALE:Float = SmH.PHYSICS_SCALE;
	
	private var PhysicsDebug:Sprite;
	private var World:B2World;
	private var bodyTest:B2Body;
	public var mouseJoint:B2MouseJoint;
	public var lA:B2Body;
	///////////////////
	public function new() {
		super();
		//////////////
		initialize ();
		construct ();
		///////////////
	}
	private function initialize ():Void {

		PhysicsDebug = new Sprite ();
	 
	}
	private function construct ():Void {
		
		World = new B2World (new B2Vec2 (0, 0.0), false);
	 
		addChild (PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit| B2DebugDraw.e_jointBit |B2DebugDraw.e_pairBit| B2DebugDraw.e_controllerBit|B2DebugDraw.e_aabbBit);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit | B2DebugDraw.e_centerOfMassBit);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit| B2DebugDraw.e_jointBit );
		//debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit);
		World.setDebugDraw (debugDraw);
	 
		//createBox (250, 100, 100, 100, true);
		//createCircle (200, 100, 20, true);
		//bodyTest = createCircle (105, 100, 30, true);
		createWalls();
		createRingWalls();
		lA=createL(150,100);
		//createVerticalRubber(100,100,100,400,10);
		//createVerticalRubber(500,100,500,400,10);
		createVerticalSensor(100,100,100,400);
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		SmH.game.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		SmH.game.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		SmH.game.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	 
	}
	var line:Sprite;
	private function createVerticalSensor(x1:Int, x2:Int, y1:Int, y2:Int):Void {
		var tt:B2Body = createEdge(x1, y1, new B2Vec2(0, 0), new B2Vec2(x2-x1, y2-y1), true, 1);
		trace(tt.getPosition().x);
		World.setContactListener(new MyContactListener(lineListener));
		
		////Visual Line
		showLine = false;
		line = new Sprite();
		addChild(line);
		////
	}
	private var showLine:Bool;
	private function lineListener(showLine:Bool):Void {
		//trace("lineListener:" +showLine);
		this.showLine = showLine;
	}
	private function createVerticalRubber(x1:Float, y1:Float,x2:Float, y2:Float,n:Int):Void {
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
	private function createL(posX:Float, posY:Float):B2Body {
		//var head:B2Body=createBox(posX, posY, 10,10, true,1,1);
		var torse:B2Body = createCircle(posX, posY + 20, 15, true,-1,2);
		/*var legA:B2Body = createBox(posX - 10, posY + 45, 10, 20, true,1,1);
		var legB:B2Body = createBox(posX + 10, posY + 45, 10, 20, true,1,1);
		
		var headBottom:Float = head.getWorldCenter().y+(5*PHYSICS_SCALE);
		createRevoluteJoint(head,torse,new B2Vec2(head.getWorldCenter().x,headBottom));
		
		var torseBottomX:Float = torse.getWorldCenter().x-(7.5*PHYSICS_SCALE);
		var torseBottomY:Float = torse.getWorldCenter().y+(15*PHYSICS_SCALE);
		createRevoluteJoint(torse,legA,new B2Vec2(torseBottomX,torseBottomY));*/
		return torse;
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
	private function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool,maskBits:Int,categoryBits:Int):B2Body {
		
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
		
		return body;
	}
	

	private function createRingWalls():Void {
		////trace("createRingWalls");
		 
		createEdge(0,0,new B2Vec2(50, 50), new B2Vec2(50,450),false);//Left.
		createEdge(0,0,new B2Vec2(50,50), new B2Vec2(450,50),false);//Top.
		createEdge(0,0,new B2Vec2(450,50), new B2Vec2(450,450),false);//Right.
		createEdge(0,0,new B2Vec2(450,450), new B2Vec2(50,450),false);//Bottom.

	}
	private function createWalls():Void {
		////trace("createWalls");
		 
		createEdge(0,0,new B2Vec2(0, 0), new B2Vec2(0,SmH.height),false);//Left.
		createEdge(0,0,new B2Vec2(0,0), new B2Vec2(SmH.width,0),false);//Top.
		createEdge(0,0,new B2Vec2(SmH.width,0), new B2Vec2(SmH.width,SmH.height),false);//Right.
		createEdge(0,0,new B2Vec2(SmH.width,SmH.height), new B2Vec2(0,SmH.height),false);//Bottom.


	}
	private function createEdge(x:Float,y:Float,v1:B2Vec2,v2:B2Vec2,asSensor:Bool,userData:Int=-1):B2Body {
		////trace("createEdge");
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		 
		v1.set(v1.x * PHYSICS_SCALE, v1.y * PHYSICS_SCALE);
		v2.set(v2.x * PHYSICS_SCALE, v2.y * PHYSICS_SCALE);

		var edge:B2PolygonShape = B2PolygonShape.asEdge(v1,v2);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = edge;
		fixtureDefinition.density = 0;
		fixtureDefinition.friction = 0.3;
		if (asSensor) {
			fixtureDefinition.isSensor = true;
		}
	 
		var body:B2Body = World.createBody (bodyDefinition);
		if(userData>0){
			body.setUserData(userData);
		}
		body.createFixture (fixtureDefinition);
		return body;
	}
	private function this_onEnterFrame (e:Event):Void {
		
		//////
		//backButton.x = bodyTest.getPosition().x/ PHYSICS_SCALE-backButton.width/2;
		//backButton.y = bodyTest.getPosition().y / PHYSICS_SCALE-backButton.height/2;
		///////
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
		/////////Line!!!
		line.graphics.clear();
		if(showLine){
			line.graphics.lineStyle(1, 0xf0f0f0);
			
			var tempX:Float = (lA.getPosition().x / PHYSICS_SCALE)-15;
			var tempY:Float = (lA.getPosition().y / PHYSICS_SCALE);
			
			line.graphics.moveTo(100,100);
			line.graphics.lineTo(tempX,tempY);
			
			line.graphics.moveTo(100,400);
			line.graphics.lineTo(tempX,tempY);
		}
		////
	}

	public function GetBodyAtMouse(includeStatic:Bool=false,e:MouseEvent):B2Body {
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
	public function callBackQueryAABB(fixture:B2Fixture):Bool {
		queriedBody = fixture.getBody();
		return true;
	}
	
	public var queriedBody:B2Body;
	public var mouseXWorldPhys:Float;
	public var mouseYWorldPhys:Float;
		
	public function onMouseDown(e:MouseEvent):Void {
		GetBodyAtMouse(false, e);
		if (queriedBody != null) {
			///
			mouseXWorldPhys=e.stageX*PHYSICS_SCALE;
			mouseYWorldPhys = e.stageY * PHYSICS_SCALE;
			//
			var mouseJointDef:B2MouseJointDef=new B2MouseJointDef();
			mouseJointDef.bodyA=World.getGroundBody();
			mouseJointDef.bodyB=queriedBody;
			mouseJointDef.target.set(mouseXWorldPhys, mouseYWorldPhys);
			mouseJointDef.maxForce=500;
			//mouseJointDef.timeStep=m_timeStep;
			//mouseJointDef.frequencyHz =  30;
			//mouseJoint =
			mouseJoint= cast(World.createJoint(mouseJointDef),B2MouseJoint);
			//trace("createJoint");
		}
		
	}
	public function onMouseMove(e:MouseEvent) {
		mouseXWorldPhys=e.stageX*PHYSICS_SCALE;
		mouseYWorldPhys = e.stageY * PHYSICS_SCALE;
	}
	public function onMouseUp(e:MouseEvent) {
		if (mouseJoint!=null) {
			World.destroyJoint(mouseJoint);
			mouseJoint = null;
			queriedBody = null;
			//trace("onMouseDown");
		}
	}
}