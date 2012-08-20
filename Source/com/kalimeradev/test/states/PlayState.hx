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
class PlayState extends SmState
{
	
	//////////////////
	private static var PHYSICS_SCALE:Float = 1 / 30;
	
	private var PhysicsDebug:Sprite;
	private var World:B2World;
	private var bodyTest:B2Body;
	public var mouseJoint:B2MouseJoint;
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
		
		World = new B2World (new B2Vec2 (0, 10.0), false);
	 
		addChild (PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit| B2DebugDraw.e_jointBit |B2DebugDraw.e_pairBit| B2DebugDraw.e_controllerBit);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit);
		//debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit);
		World.setDebugDraw (debugDraw);
	 
		//createBox (250, 100, 100, 100, true);
		//createCircle (100, 10, 20, true);
		//bodyTest = createCircle (105, 100, 30, true);
		createWalls();
		createL();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		SmH.game.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		SmH.game.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		SmH.game.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	 
	}
	private function createL():Void {
		var defHeadTorse:B2RevoluteJointDef = new B2RevoluteJointDef();
		var defTorseArmA:B2RevoluteJointDef = new B2RevoluteJointDef();
		
		var head:B2Body=createCircle(80, 40, 10, true);
		var torseA:B2Body=createBox(80, 60, 40, 20, true);
		var torseB:B2Body=createBox(80, 80, 40, 20, true);
		var torseC:B2Body=createBox(80, 100, 40, 20, true);
		var legA:B2Body=createBox(70, 130, 20, 40, true);
		var legB:B2Body=createBox(90, 130, 20, 40, true);
		
		/*defHeadTorse.initialize(head, torse, new B2Vec2(100*PHYSICS_SCALE, 150*PHYSICS_SCALE));
		defTorseArmA.initialize(torse, armA, new B2Vec2(50*PHYSICS_SCALE, 250*PHYSICS_SCALE));
		
		World.createJoint(defHeadTorse);
		World.createJoint(defTorseArmA);*/
		
		var jointTorseHeadTorseA:B2DistanceJointDef = new B2DistanceJointDef();
		jointTorseHeadTorseA.initialize(head, torseA, new B2Vec2(80 * PHYSICS_SCALE, 40 * PHYSICS_SCALE), new B2Vec2(80 * PHYSICS_SCALE, 60 * PHYSICS_SCALE));
		jointTorseHeadTorseA.collideConnected = true;
		var jointTorseAB:B2DistanceJointDef = new B2DistanceJointDef();
		jointTorseAB.initialize(torseA,torseB,new B2Vec2(80*PHYSICS_SCALE, 60*PHYSICS_SCALE),new B2Vec2(80*PHYSICS_SCALE, 80*PHYSICS_SCALE));
		jointTorseAB.collideConnected = true;
		var jointTorseBC:B2DistanceJointDef = new B2DistanceJointDef();
		jointTorseBC.initialize(torseB,torseC,new B2Vec2(80*PHYSICS_SCALE, 80*PHYSICS_SCALE),new B2Vec2(80*PHYSICS_SCALE, 100*PHYSICS_SCALE));
		jointTorseBC.collideConnected = true;
		
		var jointTorceCLegA:B2DistanceJointDef = new B2DistanceJointDef();
		jointTorceCLegA.initialize(torseC,legA,new B2Vec2(70*PHYSICS_SCALE, 100*PHYSICS_SCALE),new B2Vec2(70*PHYSICS_SCALE, 105*PHYSICS_SCALE));
		jointTorceCLegA.collideConnected = true;
		jointTorceCLegA.localAnchorB.set(0,1);
		
		var jointTorceCLegB:B2DistanceJointDef = new B2DistanceJointDef();
		jointTorceCLegB.initialize(torseC,legB,new B2Vec2(90*PHYSICS_SCALE, 100*PHYSICS_SCALE),new B2Vec2(90*PHYSICS_SCALE, 105*PHYSICS_SCALE));
		jointTorceCLegB.collideConnected = true;
		jointTorceCLegB.localAnchorB.set(0,1);
		
		World.createJoint(jointTorseHeadTorseA);
		World.createJoint(jointTorseAB);
		World.createJoint(jointTorseBC);
		World.createJoint(jointTorceCLegA);
		World.createJoint(jointTorceCLegB);
	}
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body {
	 
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);

		if (dynamicBody) {
	 
			bodyDefinition.type = B2Body.b2_dynamicBody;
	 
		}
	 
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);

		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = .5;
		fixtureDefinition.friction = 0.1;
	 
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		
		return body;
	}
	private function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool):B2Body {
		
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
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	

	private function createWalls():Void {
		////trace("createWalls");
		 
		createEdge(0,0,new B2Vec2(0, 0), new B2Vec2(0,SmH.height));//Left.
		createEdge(0,0,new B2Vec2(0,0), new B2Vec2(SmH.width,0));//Top.
		createEdge(0,0,new B2Vec2(SmH.width,0), new B2Vec2(SmH.width,SmH.height));//Right.
		createEdge(0,0,new B2Vec2(SmH.width,SmH.height), new B2Vec2(0,SmH.height));//Bottom.


	}
	private function createEdge(x:Float,y:Float,v1:B2Vec2,v2:B2Vec2):Void {
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
	 
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);

	}
	
	private function this_onEnterFrame (e:Event):Void {
		
		//////
		//backButton.x = bodyTest.getPosition().x/ PHYSICS_SCALE-backButton.width/2;
		//backButton.y = bodyTest.getPosition().y / PHYSICS_SCALE-backButton.height/2;
		
		//////
		World.step (1 / 30, 10, 10);
		World.clearForces ();
		World.drawDebugData ();
		
		///////////
		if (mouseJoint != null) {
			var p2:B2Vec2=new B2Vec2(mouseXWorldPhys,mouseYWorldPhys);
			mouseJoint.setTarget(p2);
		}
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
			mouseJointDef.maxForce=30000;
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