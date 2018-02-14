package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class ActorEvents_2 extends ActorScript
{
	public var _facingRight:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("facingRight", "_facingRight");
		_facingRight = true;
		
	}
	
	override public function init()
	{
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(4), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(event.otherActor);
				if((cast(actor.say("Health Manager", "_customBlock_GetCurrentHealth"), Float) <= 0))
				{
					recycleActor(actor);
					switchScene(GameModel.get().scenes.get(1).getID(), createFadeOut(2, Utils.getColorRGB(153,0,153)), createFadeIn(2, Utils.getColorRGB(0,0,0)));
				}
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("left", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if(_facingRight)
				{
					actor.setX((actor.getX() - 20));
					_facingRight = false;
					propertyChanged("_facingRight", _facingRight);
				}
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("right", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if(!(_facingRight))
				{
					actor.setX((actor.getX() + 20));
					_facingRight = true;
					propertyChanged("_facingRight", _facingRight);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(20), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.say("Health Manager", "_customBlock_Heal", [-2]);
				recycleActor(event.otherActor);
				if((cast(actor.say("Health Manager", "_customBlock_GetCurrentHealth"), Float) <= 0))
				{
					recycleActor(actor);
					switchScene(GameModel.get().scenes.get(2).getID(), createFadeOut(2, Utils.getColorRGB(153,0,153)), createFadeIn(2, Utils.getColorRGB(0,0,0)));
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(22), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.say("Health Manager", "_customBlock_Heal", [2]);
				recycleActor(event.otherActor);
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(8), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.say("Health Manager", "_customBlock_Damage", [2]);
				if((cast(actor.say("Health Manager", "_customBlock_GetCurrentHealth"), Float) <= 0))
				{
					recycleActor(actor);
					switchScene(GameModel.get().scenes.get(2).getID(), createFadeOut(2, Utils.getColorRGB(153,0,153)), createFadeIn(2, Utils.getColorRGB(0,0,0)));
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(6), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				switchScene(GameModel.get().scenes.get(2).getID(), createFadeOut(2, Utils.getColorRGB(153,0,153)), createFadeIn(2, Utils.getColorRGB(0,0,0)));
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}