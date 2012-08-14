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
		backButton.addEventListener(MouseEvent.CLICK, onPlayBack);
		addChild(backButton);
		////////
		trace("new");
		
		//////////////
			initialize ();
			construct ();
		///////////////
	}
	public function onPlayBack(e:MouseEvent):Void {
		/*var menuState:MenuState= new MenuState();
		SmH.switchState(menuState);*/
		
		trace(e.stageY+"+++"+e.localY);
		createCircle(e.stageX,e.stageY ,10,true);
	}
	private function initialize ():Void {
	 
		/*Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
	 */
		PhysicsDebug = new Sprite ();
	 
	}
	private function construct ():Void {
		
		World = new B2World (new B2Vec2 (0, 10.0), true);
	 
		addChild (PhysicsDebug);
	 
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		//debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit| B2DebugDraw.e_aabbBit | B2DebugDraw.e_controllerBit);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit|B2DebugDraw.e_centerOfMassBit);
		//debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit);
		World.setDebugDraw (debugDraw);
	 
		createBox (250, SmH.height, 500, 100, false);
		createBox (250, 100, 100, 100, true);
		createCircle (100, 10, 20, true);
		bodyTest = createCircle (105, 100, 50, true);
	 createMap();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	 
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
		fixtureDefinition.density = 0;
		fixtureDefinition.friction = 0.3;
	 
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
		fixtureDefinition.restitution = 2;
		fixtureDefinition.density = 0;
		fixtureDefinition.friction = .1;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	private function createMap():Void {
	 trace("createMap");
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (20 * PHYSICS_SCALE, 20 * PHYSICS_SCALE);

		/*var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);*/

		
		
// This an edge shape with ghost vertices.

var v0:B2Vec2 = new B2Vec2(1.7, 0.0);

var v1:B2Vec2 = new B2Vec2(100* PHYSICS_SCALE, 100* PHYSICS_SCALE);

var v2:B2Vec2 = new B2Vec2(300* PHYSICS_SCALE, 150* PHYSICS_SCALE);

var v3:B2Vec2 = new B2Vec2(-1.7, 0.4);

 
 

var edge:B2PolygonShape = B2PolygonShape.asEdge(v1,v2);

/*edge.m_hasVertex0 = true;

edge.m_hasVertex3 = true;

edge.m_vertex0 = v0;

edge.m_vertex3 = v3;*/


		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = edge;
		fixtureDefinition.density = 0;
		fixtureDefinition.friction = 0.3;
	 
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);

	}
	private function this_onEnterFrame (event:Event):Void {
		
		//////
		//backButton.x = bodyTest.getPosition().x/ PHYSICS_SCALE-backButton.width/2;
		//backButton.y = bodyTest.getPosition().y / PHYSICS_SCALE-backButton.height/2;
		
		//////
		World.step (1 / 30, 10, 10);
		World.clearForces ();
		World.drawDebugData ();
	}
}