package com.smlg;
//
import com.kalimeradev.test.RubberListener;
import com.kalimeradev.test.states.MenuState;
//
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
	public static var PHYSICS_SCALE:Float = 1 / 5;
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

public static function createL(x:Float, y:Float,w:Float,h:Float):SmObject {
		//Sizes
		var torseWidth:Float = w / 2;
		var torseHeight:Float = h / 2;
		
		var footWidth:Float = w / 4;
		var footHeight:Float = h / 4 ;
		
		var armWidth:Float = w / 4;
		var armHeight:Float = h / 2 ;
		
		var headWidth:Float = (h - (torseHeight + footHeight)) ;
		var headHeight:Float = (h-(torseHeight+footHeight));
		
		//Positions
		var torseX:Float = x;
		var torseY:Float = y;
		
		var headX:Float = torseX;
		var headY:Float = torseY-(torseHeight/2)-(headHeight/2);
		
		var footX:Float = torseX;
		var footY:Float = torseY+(torseHeight/2)+(footHeight/2);
		
		var armX:Float = torseX;
		var armY:Float = torseY;
		
		
		
		//Bodies
		var head:B2Body=createBox(headX, headY, headWidth,headHeight,true);//Head
		var leftFoot:B2Body=createBox(footX-footWidth/2, footY, footWidth, footHeight, true);//LeftFoot
		var rightFoot:B2Body=createBox(footX+footWidth/2, footY, footWidth, footHeight, true);//RightFoot
		var leftArm:B2Body=createBox(armX-(torseWidth/2)-(w/8), armY, armWidth, armHeight, true);//LeftArm
		var rightArm:B2Body=createBox(armX+(torseWidth/2)+(w/8), armY, armWidth, armHeight, true);//RightArm
		var torse:B2Body=createBox(torseX,torseY, torseWidth, torseHeight, true);//Torse
		
		//createBox(x,y,w,h, false, -1, -1);//Box
		
		
		////Joints
		var tempAchorA:B2Vec2 = null;
		var tempAchorB:B2Vec2 = null;
		
		tempAchorA = new B2Vec2(torseX, torseY - (torseHeight / 2)-2);
		tempAchorB = new B2Vec2(torseX, torseY - (torseHeight / 2)+2);
		createDistanceJoint(head, torse, tempAchorA, tempAchorB);//Head - Torse.
		
		tempAchorA = new B2Vec2(footX-footWidth/2, footY - (footHeight / 2)-2);
		tempAchorB = new B2Vec2(footX-footWidth/2, footY - (footHeight / 2)+2);
		createDistanceJoint(torse, leftFoot, tempAchorA, tempAchorB);//Torse - LeftFoot.
		
		tempAchorA = new B2Vec2(footX+footWidth/2, footY - (footHeight / 2)-2);
		tempAchorB = new B2Vec2(footX+footWidth/2, footY - (footHeight / 2)+2);
		createDistanceJoint(torse, rightFoot, tempAchorA, tempAchorB);//Torse - RightFoot.
		
		tempAchorA = new B2Vec2(armX-(torseWidth/2), armY - (armHeight / 2));
		tempAchorB = new B2Vec2(armX-(torseWidth/2)-2, armY - (armHeight / 2)+2);
		createDistanceJoint(torse, leftArm, tempAchorA, tempAchorB);//Torse - LeftArm.
		
		tempAchorA = new B2Vec2(armX+(torseWidth/2), armY - (armHeight / 2));
		tempAchorB = new B2Vec2(armX+(torseWidth/2)+2, armY - (armHeight / 2)+2);
		createDistanceJoint(torse, rightArm, tempAchorA, tempAchorB);//Torse - RightArm.
		
		var res:SmObject = new SmObject(torse, new Rectangle(x * PHYSICS_SCALE, y * PHYSICS_SCALE, w * PHYSICS_SCALE, h * PHYSICS_SCALE));
		
		return res;
	}
	public static function createRubber(x1:Float, y1:Float, x2:Float, y2:Float,rubberPos:Int):SmObject{
		var res:SmObject = createEdge( x1, y1, x2, y2);
		res.setProperty(SmObject.PROPERTY_SENSOR, true);
		res.setProperty(SmObject.PROPERTY_USER_DATA, [SmObject.OBJECT_TYPE_RUBBER,rubberPos]);
		return res;
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
	
	public static function createDistanceJoint(bA:B2Body,bB:B2Body,anchorA:B2Vec2, anchorB:B2Vec2,collideConnected:Bool=true):Void {
		anchorA.multiply(PHYSICS_SCALE);
		anchorB.multiply(PHYSICS_SCALE);
		
		var joint:B2DistanceJointDef = new B2DistanceJointDef();
		joint.initialize(bA, bB, anchorA, anchorB);
		//joint.localAnchorA.set(0,0);
		//joint.localAnchorB.set(0,1);
		joint.collideConnected = collideConnected;
		//joint.dampingRatio = 50*PHYSICS_SCALE;
		//joint.frequencyHz = 1000*PHYSICS_SCALE;
		World.createJoint(joint);
	}
	
public static function createBox (x:Float, y:Float, width:Float, height:Float,dynamicBody:Bool=false):B2Body {
	 
		
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
		fixtureDefinition.friction =  0.1;
		fixtureDefinition.restitution = .5;
		
		var body:B2Body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);

		return body;
	}
	
	public static function createCircle (x:Float, y:Float, radius:Float,dynamicBody:Bool=false):SmObject {

		x = x * PHYSICS_SCALE;
		y = y * PHYSICS_SCALE;
		radius = radius * PHYSICS_SCALE;
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x, y);
		
		if (dynamicBody) {
			bodyDefinition.type = B2Body.b2_dynamicBody;
		}
		
		var circle = new B2CircleShape (radius);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		fixtureDefinition.density = .1;
		fixtureDefinition.friction =0.1;
		fixtureDefinition.restitution =  .5;
		
	
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		//body.setBullet(true);
		
		var res:SmObject = new SmObject(body, new Rectangle(x, y, radius * 2, radius * 2));
		
		return res;
	}

	public static function createEdge( x1:Float,y1:Float,x2:Float,y2:Float):SmObject {

		var bodyDefinition = new B2BodyDef ();
		
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
	 
		
		var body:B2Body = World.createBody (bodyDefinition);

		body.createFixture (fixtureDefinition);

		var res:SmObject = new SmObject(body, new Rectangle(x1/PHYSICS_SCALE, y1/PHYSICS_SCALE, x2/PHYSICS_SCALE , y2/PHYSICS_SCALE ));
		
		return res;
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
			mouseJointDef.maxForce=5000;
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