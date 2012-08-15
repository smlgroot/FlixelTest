package com.kalimeradev.test.states;

/**
 * ...
 * @author smlg
 */
import box2D.collision.shapes.B2EdgeShape;
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
	private var titleResponse:SmText;
	private var titleText:String;
	
	private var backButton:SmButton;
	//////////////////
	private static var PHYSICS_SCALE:Float = 1 / 30;
	
	private var PhysicsDebug:Sprite;
	private var World:B2World;
	private var bodyTest:B2Body;
	///////////////////
	public function new() {
		super();
		titleResponse = new SmText("TITLE");
		titleResponse.x = SmH.width/2 -titleResponse.width/2;
		titleResponse.y =20;
		addChild(titleResponse);
		////////
		backButton = new SmButton("BACK", 50, 50);
		backButton.x = SmH.width/2 -backButton.width/2;
		backButton.y = SmH.height/2 -backButton.height/2;
		//backButton.addEventListener(MouseEvent.CLICK, onPlayBack);
		addChild(backButton);
		////////
		trace("new");
		
		//////////////
			initialize ();
			construct ();
		///////////////
	}
	public var mouseJoint:B2MouseJoint;
	public function onPlayBack(e:MouseEvent):Void {
		
		
		//bodyTest.applyForce(new B2Vec2(-50,-50),bodyTest.getWorldCenter());
		//trace("force applied");
		///////
		/*var menuState:MenuState= new MenuState();
		SmH.switchState(menuState);*/
		
		//trace(e.stageY+"+++"+e.localY);
		//createCircle(e.stageX, e.stageY , 10, true);
		
		/*var g:B2Vec2 = World.getGravity();
		g.y = g.y * -1;
		
		World.setGravity(g);*/
		
		GetBodyAtMouse(false, e);
		if (queriedBody!=null) {
				var mouseJointDef:B2MouseJointDef=new B2MouseJointDef();
				mouseJointDef.bodyA=World.getGroundBody();
				mouseJointDef.bodyB=queriedBody;
				mouseJointDef.target.set(e.stageX*PHYSICS_SCALE, e.stageX*PHYSICS_SCALE);
				mouseJointDef.maxForce=30000;
				//mouseJointDef.timeStep=m_timeStep;
				mouseJointDef.frequencyHz =  30;
				//mouseJoint =
				mouseJoint= cast(World.createJoint(mouseJointDef),B2MouseJoint);
				trace("createJoint");
		}
		
		trace("finish GetBodyAtMouse");
	}
	private function initialize ():Void {
	 
		/*Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	 */
		PhysicsDebug = new Sprite ();
	 
	}
	private function construct ():Void {
		
		World = new B2World (new B2Vec2 (0, 10.0), false);
	 
		addChild (PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit| B2DebugDraw.e_aabbBit | B2DebugDraw.e_controllerBit);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit);
		//debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit);
		World.setDebugDraw (debugDraw);
	 
		//createBox (0, SmH.height,  SmH.width, 100, false);
		createBox (250, 100, 100, 100, true);
		createCircle (100, 10, 20, true);
		bodyTest = createCircle (105, 100, 30, true);
	 createMap();
	 createWalls();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		SmH.game.addEventListener(MouseEvent.MOUSE_DOWN, onPlayBack);
		SmH.game.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		SmH.game.addEventListener(MouseEvent.MOUSE_UP, onMouseDown);
	 
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
		fixtureDefinition.density = 1;
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
		fixtureDefinition.density = .1;
		fixtureDefinition.friction = .1;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	private function createMap():Void {
		trace("createMap");
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (100 * PHYSICS_SCALE, 100 * PHYSICS_SCALE);

		// This an edge shape with ghost vertices.

		var v0:B2Vec2 = new B2Vec2(0* PHYSICS_SCALE, 100* PHYSICS_SCALE);

		var v1:B2Vec2 = new B2Vec2(100* PHYSICS_SCALE, 100* PHYSICS_SCALE);

		var v2:B2Vec2 = new B2Vec2(200* PHYSICS_SCALE, 200* PHYSICS_SCALE);

		var v3:B2Vec2 = new B2Vec2(200* PHYSICS_SCALE, 300* PHYSICS_SCALE);
		
		var v4:B2Vec2 = new B2Vec2(0* PHYSICS_SCALE, 100* PHYSICS_SCALE);

		var edge:B2PolygonShape = B2PolygonShape.asArray([v0, v1, v2, v3,v4], 4);
		var edge2:B2EdgeShape = new B2EdgeShape(v0, v1);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = edge;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 0.3;
	 
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);

	}
	
	private function createWalls():Void {
		trace("createWalls");
		 
		createEdge(0,0,new B2Vec2(0, 0), new B2Vec2(0,SmH.height));//Left.
		createEdge(0,0,new B2Vec2(0,0), new B2Vec2(SmH.width,0));//Top.
		createEdge(0,0,new B2Vec2(SmH.width,0), new B2Vec2(SmH.width,SmH.height));//Right.
		createEdge(0,0,new B2Vec2(SmH.width,SmH.height), new B2Vec2(0,SmH.height));//Bottom.


	}
	private function createEdge(x:Float,y:Float,v1:B2Vec2,v2:B2Vec2):Void {
		trace("createEdge");
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
		public var queriedBody:B2Body;
		public function callBackQueryAABB(fixture:B2Fixture):Bool {
			trace(fixture);
			queriedBody = fixture.getBody();
			return fixture!=null;
		}
		
		public var mouseXWorldPhys:Float;
		public var mouseYWorldPhys:Float;
		
		public function onMouseMove(e:MouseEvent) {
			mouseXWorldPhys=e.stageX*PHYSICS_SCALE;
			mouseYWorldPhys=e.stageY*PHYSICS_SCALE;
		}
		public function onMouseDown(e:MouseEvent) {
			if (mouseJoint!=null) {
				World.destroyJoint(mouseJoint);
				mouseJoint = null;
				trace("onMouseDown");
			}
		}
}