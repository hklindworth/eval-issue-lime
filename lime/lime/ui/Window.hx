package lime.ui;


import lime.app.Application;
import lime.app.Config;
import lime.app.Event;
import lime.graphics.Image;
import lime.graphics.Renderer;
import lime.system.Display;
import lime.system.DisplayMode;

#if openfl
import openfl.display.Stage;
#elseif flash
import flash.display.Stage;
#else
typedef Stage = Dynamic;
#end

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


class Window {
	
	
	public var application (default, null):Application;
	public var borderless (get, set):Bool;
	public var config:WindowConfig;
	public var display (get, null):Display;
	public var displayMode (get, set):DisplayMode;
	public var enableTextEvents (get, set):Bool;
	public var fullscreen (get, set):Bool;
	public var height (get, set):Int;
	public var id (default, null):Int;
	public var maximized (get, set):Bool;
	public var minimized (get, set):Bool;
	public var onActivate = new Event<Void->Void> ();
	public var onClose = new Event<Void->Void> ();
	public var onCreate = new Event<Void->Void> ();
	public var onDeactivate = new Event<Void->Void> ();
	public var onDropFile = new Event<String->Void> ();
	public var onEnter = new Event<Void->Void> ();
	public var onFocusIn = new Event<Void->Void> ();
	public var onFocusOut = new Event<Void->Void> ();
	public var onFullscreen = new Event<Void->Void> ();
	public var onKeyDown = new Event<KeyCode->KeyModifier->Void> ();
	public var onKeyUp = new Event<KeyCode->KeyModifier->Void> ();
	public var onLeave = new Event<Void->Void> ();
	public var onMinimize = new Event<Void->Void> ();
	public var onMouseDown = new Event<Float->Float->Int->Void> ();
	public var onMouseMove = new Event<Float->Float->Void> ();
	public var onMouseMoveRelative = new Event<Float->Float->Void> ();
	public var onMouseUp = new Event<Float->Float->Int->Void> ();
	public var onMouseWheel = new Event<Float->Float->Void> ();
	public var onMove = new Event<Float->Float->Void> ();
	public var onResize = new Event<Int->Int->Void> ();
	public var onRestore = new Event<Void->Void> ();
	public var onTextEdit = new Event<String->Int->Int->Void> ();
	public var onTextInput = new Event<String->Void> ();
	public var renderer:Renderer;
	public var resizable (get, set):Bool;
	public var scale (get, null):Float;
	public var stage:Stage;
	public var title (get, set):String;
	public var width (get, set):Int;
	public var x (get, set):Int;
	public var y (get, set):Int;
	
	@:noCompletion private var backend:WindowBackend;
	@:noCompletion private var __borderless:Bool;
	@:noCompletion private var __fullscreen:Bool;
	@:noCompletion private var __height:Int;
	@:noCompletion private var __maximized:Bool;
	@:noCompletion private var __minimized:Bool;
	@:noCompletion private var __resizable:Bool;
	@:noCompletion private var __scale:Float;
	@:noCompletion private var __title:String;
	@:noCompletion private var __width:Int;
	@:noCompletion private var __x:Int;
	@:noCompletion private var __y:Int;
	
	
	public function new (config:WindowConfig = null) {
		
		this.config = config;
		
		__width = 0;
		__height = 0;
		__fullscreen = false;
		__scale = 1;
		__x = 0;
		__y = 0;
		__title = "";
		id = -1;
		
		if (config != null) {
			
			if (Reflect.hasField (config, "width")) __width = config.width;
			if (Reflect.hasField (config, "height")) __height = config.height;
			if (Reflect.hasField (config, "x")) __x = config.x;
			if (Reflect.hasField (config, "y")) __y = config.y;
			#if !web
			if (Reflect.hasField (config, "fullscreen")) __fullscreen = config.fullscreen;
			#end
			if (Reflect.hasField (config, "borderless")) __borderless = config.borderless;
			if (Reflect.hasField (config, "resizable")) __resizable = config.resizable;
			if (Reflect.hasField (config, "title")) __title = config.title;
			
		}
		
		backend = new WindowBackend (this);
		
	}
	
	
	public function alert (message:String = null, title:String = null):Void {
		
		backend.alert (message, title);
		
	}
	
	
	public function close ():Void {
		
		backend.close ();
		
	}
	
	
	public function create (application:Application):Void {
		
		this.application = application;
		
		backend.create (application);
		
		#if windows
		
		var mappings = [
			
			"8f0e1200000000000000504944564944,Acme,platform:Windows,x:b2,a:b0,b:b1,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b5,rightshoulder:b6,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2",
			"341a3608000000000000504944564944,Afterglow PS3 Controller,a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b12,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Windows",
			"ffff0000000000000000504944564944,GameStop Gamepad,a:b0,b:b1,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b2,y:b3,platform:Windows",
			"6d0416c2000000000000504944564944,Generic DirectInput Controller,a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Windows",
			"0d0f6e00000000000000504944564944,HORIPAD 4,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"6d0419c2000000000000504944564944,Logitech F710 Gamepad,a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Windows",
			"88880803000000000000504944564944,PS3 Controller,a:b2,b:b1,back:b8,dpdown:h0.8,dpleft:h0.4,dpright:h0.2,dpup:h0.1,guide:b12,leftshoulder:b4,leftstick:b9,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:b7,rightx:a3,righty:a4,start:b11,x:b0,y:b3,platform:Windows",
			"4c056802000000000000504944564944,PS3 Controller,a:b14,b:b13,back:b0,dpdown:b6,dpleft:b7,dpright:b5,dpup:b4,guide:b16,leftshoulder:b10,leftstick:b1,lefttrigger:b8,leftx:a0,lefty:a1,rightshoulder:b11,rightstick:b2,righttrigger:b9,rightx:a2,righty:a3,start:b3,x:b15,y:b12,platform:Windows",
			"25090500000000000000504944564944,PS3 DualShock,a:b2,b:b1,back:b9,dpdown:h0.8,dpleft:h0.4,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b6,leftstick:b10,lefttrigger:b4,leftx:a0,lefty:a1,rightshoulder:b7,rightstick:b11,righttrigger:b5,rightx:a2,righty:a3,start:b8,x:b0,y:b3,platform:Windows",
			"4c05c405000000000000504944564944,Sony DualShock 4,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Windows",
			"4c05cc09000000000000504944564944,Sony DualShock 4,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Windows",
			"4c05a00b000000000000504944564944,Sony DualShock 4 Wireless Adaptor,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Windows",
			"6d0418c2000000000000504944564944,Logitech RumblePad 2 USB,platform:Windows,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"36280100000000000000504944564944,OUYA Controller,platform:Windows,a:b0,b:b3,y:b2,x:b1,start:b14,guide:b15,leftstick:b6,rightstick:b7,leftshoulder:b4,rightshoulder:b5,dpup:b8,dpleft:b10,dpdown:b9,dpright:b11,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:b12,righttrigger:b13",
			"4f0400b3000000000000504944564944,Thrustmaster Firestorm Dual Power,a:b0,b:b2,y:b3,x:b1,start:b10,guide:b8,back:b9,leftstick:b11,rightstick:b12,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b5,righttrigger:b7,platform:Windows",
			"00f00300000000000000504944564944,RetroUSB.com RetroPad,a:b1,b:b5,x:b0,y:b4,back:b2,start:b3,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Windows",
			"00f0f100000000000000504944564944,RetroUSB.com Super RetroPort,a:b1,b:b5,x:b0,y:b4,back:b2,start:b3,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Windows",
			"28040140000000000000504944564944,GamePad Pro USB,platform:Windows,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,lefttrigger:b6,righttrigger:b7",
			"ff113133000000000000504944564944,SVEN X-PAD,platform:Windows,a:b2,b:b3,y:b1,x:b0,start:b5,back:b4,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a4,lefttrigger:b8,righttrigger:b9",
			"8f0e0300000000000000504944564944,Piranha xtreme,platform:Windows,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b6,lefttrigger:b4,rightshoulder:b7,righttrigger:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2",
			"8f0e0d31000000000000504944564944,Multilaser JS071 USB,platform:Windows,a:b1,b:b2,y:b3,x:b0,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
			"10080300000000000000504944564944,PS2 USB,platform:Windows,a:b2,b:b1,y:b0,x:b3,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a4,righty:a2,lefttrigger:b4,righttrigger:b5",
			"79000600000000000000504944564944,G-Shark GS-GP702,a:b2,b:b1,x:b3,y:b0,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a4,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"4b12014d000000000000504944564944,NYKO AIRFLO,a:b0,b:b1,x:b2,y:b3,back:b8,guide:b10,start:b9,leftstick:a0,rightstick:a2,leftshoulder:a3,rightshoulder:b5,dpup:h0.1,dpdown:h0.0,dpleft:h0.8,dpright:h0.2,leftx:h0.6,lefty:h0.12,rightx:h0.9,righty:h0.4,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"d6206dca000000000000504944564944,PowerA Pro Ex,a:b1,b:b2,x:b0,y:b3,back:b8,guide:b12,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.0,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"a3060cff000000000000504944564944,Saitek P2500,a:b2,b:b3,y:b1,x:b0,start:b4,guide:b10,back:b5,leftstick:b8,rightstick:b9,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Windows",
			"4f0415b3000000000000504944564944,Thrustmaster Dual Analog 3.2,platform:Windows,x:b1,a:b0,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b5,rightshoulder:b6,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"6f0e1e01000000000000504944564944,Rock Candy Gamepad for PS3,platform:Windows,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,guide:b12,leftshoulder:b4,rightshoulder:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2",
			"83056020000000000000504944564944,iBuffalo USB 2-axis 8-button Gamepad,a:b1,b:b0,y:b2,x:b3,start:b7,back:b6,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Windows",
			"10080100000000000000504944564944,PS1 USB,platform:Windows,a:b2,b:b1,x:b3,y:b0,back:b8,start:b9,leftshoulder:b6,rightshoulder:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b4,righttrigger:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2",
			"49190204000000000000504944564944,Ipega PG-9023,a:b0,b:b1,x:b3,y:b4,back:b10,start:b11,leftstick:b13,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:b8,righttrigger:b9,platform:Windows",
			"4f0423b3000000000000504944564944,Dual Trigger 3-in-1,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"0d0f4900000000000000504944564944,Hatsune Miku Sho Controller,a:b1,b:b2,x:b0,y:b3,back:b8,guide:b12,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"79004318000000000000504944564944,Mayflash GameCube Controller Adapter,platform:Windows,a:b1,b:b2,x:b0,y:b3,back:b0,start:b9,guide:b0,leftshoulder:b4,rightshoulder:b7,leftstick:b0,rightstick:b0,leftx:a0,lefty:a1,rightx:a5,righty:a2,lefttrigger:a3,righttrigger:a4,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2",
			"79000018000000000000504944564944,Mayflash WiiU Pro Game Controller Adapter (DInput),a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"2509e803000000000000504944564944,Mayflash Wii Classic Controller,a:b1,b:b0,x:b3,y:b2,back:b8,guide:b10,start:b9,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:b11,dpdown:b13,dpleft:b12,dpright:b14,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Windows",
			"300f1001000000000000504944564944,Saitek P480 Rumble Pad,a:b2,b:b3,x:b0,y:b1,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b5,righttrigger:b7,platform:Windows",
			"10280900000000000000504944564944,8Bitdo SFC30 GamePad,a:b1,b:b0,y:b3,x:b4,start:b11,back:b10,leftshoulder:b6,leftx:a0,lefty:a1,rightshoulder:b7,platform:Windows",
			"63252305000000000000504944564944,USB Vibration Joystick (BM),platform:Windows,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"20380900000000000000504944564944,8Bitdo NES30 PRO Wireless,platform:Windows,a:b0,b:b1,x:b3,y:b4,leftshoulder:b6,rightshoulder:b7,lefttrigger:b8,righttrigger:b9,back:b10,start:b11,leftstick:b13,rightstick:b14,leftx:a0,lefty:a1,rightx:a3,righty:a4,dpup:h0.1,dpright:h0.2,dpdown:h0.4,dpleft:h0.8",
			"02200090000000000000504944564944,8Bitdo NES30 PRO USB,platform:Windows,a:b0,b:b1,x:b3,y:b4,leftshoulder:b6,rightshoulder:b7,lefttrigger:b8,righttrigger:b9,back:b10,start:b11,leftstick:b13,rightstick:b14,leftx:a0,lefty:a1,rightx:a3,righty:a4,dpup:h0.1,dpright:h0.2,dpdown:h0.4,dpleft:h0.8",
			"ff113133000000000000504944564944,Gembird JPD-DualForce,platform:Windows,a:b2,b:b3,x:b0,y:b1,start:b9,back:b8,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a4,lefttrigger:b6,righttrigger:b7,leftstick:b10,rightstick:b11",
			"341a0108000000000000504944564944,EXEQ RF USB Gamepad 8206,a:b0,b:b1,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,leftstick:b8,rightstick:b7,back:b8,start:b9,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Windows",
			"c0111352000000000000504944564944,Battalife Joystick,platform:Windows,x:b4,a:b6,b:b7,y:b5,back:b2,start:b3,leftshoulder:b0,rightshoulder:b1,leftx:a0,lefty:a1",
			"100801e5000000000000504944564944,NEXT Classic USB Game Controller,a:b0,b:b1,back:b8,start:b9,rightx:a2,righty:a3,leftx:a0,lefty:a1,platform:Windows",
			"79000600000000000000504944564944,NGS Phantom,a:b2,b:b3,y:b1,x:b0,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a4,lefttrigger:b6,righttrigger:b7,platform:Windows"
			
		];
		
		Gamepad.addMappings (mappings);
		
		#elseif mac
		
		var mappings = [
			
			"0500000047532047616d657061640000,GameStop Gamepad,a:b0,b:b1,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b2,y:b3,platform:Mac OS X",
			"6d0400000000000016c2000000000000,Logitech F310 Gamepad (DInput),a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Mac OS X",
			"6d0400000000000018c2000000000000,Logitech F510 Gamepad (DInput),a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Mac OS X",
			"6d040000000000001fc2000000000000,Logitech F710 Gamepad (XInput),a:b0,b:b1,back:b9,dpdown:b12,dpleft:b13,dpright:b14,dpup:b11,guide:b10,leftshoulder:b4,leftstick:b6,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b7,righttrigger:a5,rightx:a3,righty:a4,start:b8,x:b2,y:b3,platform:Mac OS X",
			"6d0400000000000019c2000000000000,Logitech Wireless Gamepad (DInput),a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Mac OS X",
			"4c050000000000006802000000000000,PS3 Controller,a:b14,b:b13,back:b0,dpdown:b6,dpleft:b7,dpright:b5,dpup:b4,guide:b16,leftshoulder:b10,leftstick:b1,lefttrigger:b8,leftx:a0,lefty:a1,rightshoulder:b11,rightstick:b2,righttrigger:b9,rightx:a2,righty:a3,start:b3,x:b15,y:b12,platform:Mac OS X",
			"4c05000000000000c405000000000000,Sony DualShock 4,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Mac OS X",
			"4c05000000000000cc09000000000000,Sony DualShock 4 V2,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Mac OS X",
			"5e040000000000008e02000000000000,X360 Controller,a:b0,b:b1,back:b9,dpdown:b12,dpleft:b13,dpright:b14,dpup:b11,guide:b10,leftshoulder:b4,leftstick:b6,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b7,righttrigger:a5,rightx:a3,righty:a4,start:b8,x:b2,y:b3,platform:Mac OS X",
			"891600000000000000fd000000000000,Razer Onza Tournament,a:b0,b:b1,y:b3,x:b2,start:b8,guide:b10,back:b9,leftstick:b6,rightstick:b7,leftshoulder:b4,rightshoulder:b5,dpup:b11,dpleft:b13,dpdown:b12,dpright:b14,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Mac OS X",
			"4f0400000000000000b3000000000000,Thrustmaster Firestorm Dual Power,a:b0,b:b2,y:b3,x:b1,start:b10,guide:b8,back:b9,leftstick:b11,rightstick:,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b5,righttrigger:b7,platform:Mac OS X",
			"8f0e0000000000000300000000000000,Piranha xtreme,platform:Mac OS X,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b6,lefttrigger:b4,rightshoulder:b7,righttrigger:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2",
			"0d0f0000000000004d00000000000000,HORI Gem Pad 3,platform:Mac OS X,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
			"79000000000000000600000000000000,G-Shark GP-702,a:b2,b:b1,x:b3,y:b0,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:b6,righttrigger:b7,platform:Mac OS X",
			"4f0400000000000015b3000000000000,Thrustmaster Dual Analog 3.2,platform:Mac OS X,x:b1,a:b0,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b5,rightshoulder:b6,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"AD1B00000000000001F9000000000000,Gamestop BB-070 X360 Controller,a:b0,b:b1,back:b9,dpdown:b12,dpleft:b13,dpright:b14,dpup:b11,guide:b10,leftshoulder:b4,leftstick:b6,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b7,righttrigger:a5,rightx:a3,righty:a4,start:b8,x:b2,y:b3,platform:Mac OS X",
			"050000005769696d6f74652028303000,Wii Remote,a:b4,b:b5,y:b9,x:b10,start:b6,guide:b8,back:b7,dpup:b2,dpleft:b0,dpdown:b3,dpright:b1,leftx:a0,lefty:a1,lefttrigger:b12,righttrigger:,leftshoulder:b11,platform:Mac OS X",
			"83050000000000006020000000000000,iBuffalo USB 2-axis 8-button Gamepad,a:b1,b:b0,x:b3,y:b2,back:b6,start:b7,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Mac OS X",
			"bd1200000000000015d0000000000000,Tomee SNES USB Controller,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Mac OS X",
			"79000000000000001100000000000000,Retrolink Classic Controller,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,leftshoulder:b4,rightshoulder:b5,leftx:a3,lefty:a4,platform:Mac OS X",
			"5e04000000000000dd02000000000000,Xbox One Wired Controller,platform:Mac OS X,x:b2,a:b0,b:b1,y:b3,back:b9,guide:b10,start:b8,dpleft:b13,dpdown:b12,dpright:b14,dpup:b11,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b6,rightstick:b7,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"5e04000000000000ea02000000000000,Xbox Wireless Controller,platform:Mac OS X,x:b2,a:b0,b:b1,y:b3,back:b9,guide:b10,start:b8,dpleft:b13,dpdown:b12,dpright:b14,dpup:b11,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b6,rightstick:b7,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"5e04000000000000e002000000000000,Xbox Wireless Controller,platform:Mac OS X,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b10,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b8,rightstick:b9,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"050000005769696d6f74652028313800,Wii U Pro Controller,a:b16,b:b15,x:b18,y:b17,back:b7,guide:b8,start:b6,leftstick:b23,rightstick:b24,leftshoulder:b19,rightshoulder:b20,dpup:b11,dpdown:b12,dpleft:b13,dpright:b14,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b21,righttrigger:b22,platform:Mac OS X",
			"79000000000000000018000000000000,Mayflash WiiU Pro Game Controller Adapter (DInput),a:b4,b:b8,x:b0,y:b12,back:b32,start:b36,leftstick:b40,rightstick:b44,leftshoulder:b16,rightshoulder:b20,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a4,rightx:a8,righty:a12,lefttrigger:b24,righttrigger:b28,platform:Mac OS X",
			"2509000000000000e803000000000000,Mayflash Wii Classic Controller,a:b1,b:b0,x:b3,y:b2,back:b8,guide:b10,start:b9,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:b11,dpdown:b13,dpleft:b12,dpright:b14,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Mac OS X",
			"351200000000000021ab000000000000,SFC30 Joystick,a:b1,b:b0,x:b4,y:b3,back:b10,start:b11,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Mac OS X",
			"b4040000000000000a01000000000000,Sega Saturn USB Gamepad,a:b0,b:b1,x:b3,y:b4,back:b5,guide:b2,start:b8,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Mac OS X",
			"81170000000000007e05000000000000,Sega Saturn,x:b0,a:b2,b:b4,y:b6,start:b13,dpleft:b15,dpdown:b16,dpright:b14,dpup:b17,leftshoulder:b8,lefttrigger:a5,lefttrigger:b10,rightshoulder:b9,righttrigger:a4,righttrigger:b11,leftx:a0,lefty:a2,platform:Mac OS X",
			"10280000000000000900000000000000,8Bitdo SFC30 GamePad,a:b1,b:b0,x:b4,y:b3,back:b10,start:b11,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Mac OS X",
			"d814000000000000cecf000000000000,MC Cthulhu,platform:Mac OS X,leftx:,lefty:,rightx:,righty:,lefttrigger:b6,a:b1,b:b2,y:b3,x:b0,start:b9,back:b8,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,righttrigger:b7",
			"0d0f0000000000006600000000000000,HORIPAD FPS PLUS 4,platform:Mac OS X,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:b6,righttrigger:a4"
			
		];
		
		Gamepad.addMappings (mappings);
		
		#elseif linux
		
		var mappings = [
			
			"0500000047532047616d657061640000,GameStop Gamepad,a:b0,b:b1,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b2,y:b3,platform:Linux",
			"03000000ba2200002010000001010000,Jess Technology USB Game Controller,a:b2,b:b1,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b4,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,righttrigger:b7,rightx:a3,righty:a2,start:b9,x:b3,y:b0,platform:Linux",
			"030000006d04000019c2000010010000,Logitech Cordless RumblePad 2,a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Linux",
			"030000006d0400001dc2000014400000,Logitech F310 Gamepad (XInput),a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000006d04000016c2000011010000,Logitech F310 Gamepad (DInput),x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Linux",
			"030000006d0400001ec2000020200000,Logitech F510 Gamepad (XInput),a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000006d04000019c2000011010000,Logitech F710 Gamepad (DInput),a:b1,b:b2,back:b8,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,leftstick:b10,lefttrigger:b6,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:b7,rightx:a2,righty:a3,start:b9,x:b0,y:b3,platform:Linux",
			"030000006d0400001fc2000005030000,Logitech F710 Gamepad (XInput),a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000004c0500006802000011010000,PS3 Controller,a:b14,b:b13,back:b0,dpdown:b6,dpleft:b7,dpright:b5,dpup:b4,guide:b16,leftshoulder:b10,leftstick:b1,lefttrigger:b8,leftx:a0,lefty:a1,rightshoulder:b11,rightstick:b2,righttrigger:b9,rightx:a2,righty:a3,start:b3,x:b15,y:b12,platform:Linux",
			"030000004c050000c405000011010000,Sony DualShock 4,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Linux",
			"050000004c050000c405000000010000,Sony DualShock 4 BT,a:b1,b:b2,back:b13,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b12,leftshoulder:b4,leftstick:b10,lefttrigger:a3,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b11,righttrigger:a4,rightx:a2,righty:a5,start:b9,x:b0,y:b3,platform:Linux",
			"030000004c050000cc09000011010000,Sony DualShock 4 V2,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Linux",
			"050000004c050000cc09000000010000,Sony DualShock 4 V2 BT,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Linux",
			"030000004c050000a00b000011010000,Sony DualShock 4 Wireless Adaptor,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b13,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:a3,righttrigger:a4,platform:Linux",
			"030000006f0e00003001000001010000,EA Sports PS3 Controller,platform:Linux,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
			"03000000de280000ff11000001000000,Valve Streaming Gamepad,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000005e0400008e02000014010000,X360 Controller,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000005e0400008e02000010010000,X360 Controller,a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"030000005e0400001907000000010000,X360 Wireless Controller,a:b0,b:b1,back:b6,dpdown:b14,dpleft:b11,dpright:b12,dpup:b13,guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,righty:a4,start:b7,x:b2,y:b3,platform:Linux",
			"03000000100800000100000010010000,Twin USB PS2 Adapter,a:b2,b:b1,y:b0,x:b3,start:b9,guide:,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b4,righttrigger:b5,platform:Linux",
			"03000000a306000023f6000011010000,Saitek Cyborg V.1 Game Pad,a:b1,b:b2,y:b3,x:b0,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a4,lefttrigger:b6,righttrigger:b7,platform:Linux",
			"030000004f04000020b3000010010000,Thrustmaster 2 in 1 DT,a:b0,b:b2,y:b3,x:b1,start:b9,guide:,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b5,righttrigger:b7,platform:Linux",
			"030000004f04000023b3000000010000,Thrustmaster Dual Trigger 3-in-1,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a5",
			"030000008f0e00000300000010010000,GreenAsia Inc.    USB Joystick     ,platform:Linux,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b6,lefttrigger:b4,rightshoulder:b7,righttrigger:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2",
			"030000008f0e00001200000010010000,GreenAsia Inc.      USB  Joystick  ,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b5,rightshoulder:b6,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a2",
			"030000005e0400009102000007010000,X360 Wireless Controller,a:b0,b:b1,y:b3,x:b2,start:b7,guide:b8,back:b6,leftstick:b9,rightstick:b10,leftshoulder:b4,rightshoulder:b5,dpup:b13,dpleft:b11,dpdown:b14,dpright:b12,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Linux",
			"030000006d04000016c2000010010000,Logitech Logitech Dual Action,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"03000000260900008888000000010000,GameCube {WiseGroup USB box},a:b0,b:b2,y:b3,x:b1,start:b7,leftshoulder:,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,rightstick:,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a4,righttrigger:a5,platform:Linux",
			"030000006d04000011c2000010010000,Logitech WingMan Cordless RumblePad,a:b0,b:b1,y:b4,x:b3,start:b8,guide:b5,back:b2,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:b9,righttrigger:b10,platform:Linux",
			"030000006d04000018c2000010010000,Logitech Logitech RumblePad 2 USB,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"05000000d6200000ad0d000001000000,Moga Pro,platform:Linux,a:b0,b:b1,y:b3,x:b2,start:b6,leftstick:b7,rightstick:b8,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a5,righttrigger:a4",
			"030000004f04000009d0000000010000,Thrustmaster Run N Drive Wireless PS3,platform:Linux,a:b1,b:b2,x:b0,y:b3,start:b9,guide:b12,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
			"030000004f04000008d0000000010000,Thrustmaster Run N Drive  Wireless,platform:Linux,a:b1,b:b2,x:b0,y:b3,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a5,lefttrigger:b6,righttrigger:b7",
			"0300000000f000000300000000010000,RetroUSB.com RetroPad,a:b1,b:b5,x:b0,y:b4,back:b2,start:b3,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Linux",
			"0300000000f00000f100000000010000,RetroUSB.com Super RetroPort,a:b1,b:b5,x:b0,y:b4,back:b2,start:b3,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1,platform:Linux",
			"030000006f0e00001f01000000010000,Generic X-Box pad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000280400000140000000010000,Gravis GamePad Pro USB ,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftx:a0,lefty:a1",
			"030000005e0400008902000021010000,Microsoft X-Box pad v2 (US),platform:Linux,x:b3,a:b0,b:b1,y:b4,back:b6,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b5,lefttrigger:a2,rightshoulder:b2,righttrigger:a5,leftstick:b8,rightstick:b9,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000005e0400008502000000010000,Microsoft X-Box pad (Japan),platform:Linux,x:b3,a:b0,b:b1,y:b4,back:b6,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b5,lefttrigger:a2,rightshoulder:b2,righttrigger:a5,leftstick:b8,rightstick:b9,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000006f0e00001e01000011010000,Rock Candy Gamepad for PS3,platform:Linux,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,guide:b12,leftshoulder:b4,rightshoulder:b5,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2",
			"03000000250900000500000000010000,Sony PS2 pad with SmartJoy adapter,platform:Linux,a:b2,b:b1,y:b0,x:b3,start:b8,back:b9,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b4,righttrigger:b5",
			"030000008916000000fd000024010000,Razer Onza Tournament,a:b0,b:b1,y:b3,x:b2,start:b7,guide:b8,back:b6,leftstick:b9,rightstick:b10,leftshoulder:b4,rightshoulder:b5,dpup:b13,dpleft:b11,dpdown:b14,dpright:b12,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Linux",
			"030000004f04000000b3000010010000,Thrustmaster Firestorm Dual Power,a:b0,b:b2,y:b3,x:b1,start:b10,guide:b8,back:b9,leftstick:b11,rightstick:b12,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b5,righttrigger:b7,platform:Linux",
			"03000000ad1b000001f5000033050000,Hori Pad EX Turbo 2,a:b0,b:b1,y:b3,x:b2,start:b7,guide:b8,back:b6,leftstick:b9,rightstick:b10,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Linux",
			"060000004c0500006802000000010000,PS3 Controller (Bluetooth),a:b14,b:b13,y:b12,x:b15,start:b3,guide:b16,back:b0,leftstick:b1,rightstick:b2,leftshoulder:b10,rightshoulder:b11,dpup:b4,dpleft:b7,dpdown:b6,dpright:b5,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9,platform:Linux",
			"050000004c0500006802000000010000,PS3 Controller (Bluetooth),a:b14,b:b13,y:b12,x:b15,start:b3,guide:b16,back:b0,leftstick:b1,rightstick:b2,leftshoulder:b10,rightshoulder:b11,dpup:b4,dpleft:b7,dpdown:b6,dpright:b5,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9,platform:Linux",
			"03000000790000000600000010010000,DragonRise Inc.   Generic   USB  Joystick  ,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a3,rightx:a1,righty:a4",
			"03000000666600000488000000010000,Super Joy Box 5 Pro,platform:Linux,a:b2,b:b1,x:b3,y:b0,back:b9,start:b8,leftshoulder:b6,rightshoulder:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b4,righttrigger:b5,dpup:b12,dpleft:b15,dpdown:b14,dpright:b13",
			"05000000362800000100000002010000,OUYA Game Controller,a:b0,b:b3,dpdown:b9,dpleft:b10,dpright:b11,dpup:b8,guide:b14,leftshoulder:b4,leftstick:b6,lefttrigger:a2,leftx:a0,lefty:a1,platform:Linux,rightshoulder:b5,rightstick:b7,righttrigger:a5,rightx:a3,righty:a4,x:b1,y:b2",
			"05000000362800000100000003010000,OUYA Game Controller,a:b0,b:b3,dpdown:b9,dpleft:b10,dpright:b11,dpup:b8,guide:b14,leftshoulder:b4,leftstick:b6,lefttrigger:a2,leftx:a0,lefty:a1,platform:Linux,rightshoulder:b5,rightstick:b7,righttrigger:a5,rightx:a3,righty:a4,x:b1,y:b2",
			"030000008916000001fd000024010000,Razer Onza Classic Edition,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:b11,dpdown:b14,dpright:b12,dpup:b13,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000005e040000d102000001010000,Microsoft X-Box One pad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000005e040000dd02000003020000,Microsoft X-Box One pad v2,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4,platform:Linux",
			"03000000790000001100000010010000,RetroLink Saturn Classic Controller,platform:Linux,x:b3,a:b0,b:b1,y:b4,back:b5,guide:b2,start:b8,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1",
			"050000007e0500003003000001000000,Nintendo Wii U Pro Controller,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b8,start:b9,guide:b10,leftshoulder:b4,rightshoulder:b5,leftstick:b11,rightstick:b12,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,dpup:b13,dpleft:b15,dpdown:b14,dpright:b16",
			"030000005e0400008e02000004010000,Microsoft X-Box 360 pad,platform:Linux,a:b0,b:b1,x:b2,y:b3,back:b6,start:b7,guide:b8,leftshoulder:b4,rightshoulder:b5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2",
			"030000000d0f00002200000011010000,HORI CO. LTD. REAL ARCADE Pro.V3,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,guide:b12,start:b9,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1",
			"030000000d0f00001000000011010000,HORI CO. LTD. FIGHTING STICK 3,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,guide:b12,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7",
			"03000000f0250000c183000010010000,Goodbetterbest Ltd USB Controller,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,guide:b12,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"0000000058626f782047616d65706100,Xbox Gamepad (userspace driver),platform:Linux,a:b0,b:b1,x:b2,y:b3,start:b7,back:b6,guide:b8,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftshoulder:b4,rightshoulder:b5,lefttrigger:a5,righttrigger:a4,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"03000000ff1100003133000010010000,PC Game Controller,a:b2,b:b1,y:b0,x:b3,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7,platform:Linux",
			"030000005e0400008e02000020200000,SpeedLink XEOX Pro Analog Gamepad pad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000006f0e00001304000000010000,Generic X-Box pad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:a0,rightstick:a3,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000a306000018f5000010010000,Saitek PLC Saitek P3200 Rumble Pad,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,start:b9,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000830500006020000010010000,iBuffalo USB 2-axis 8-button Gamepad,a:b1,b:b0,x:b3,y:b2,back:b6,start:b7,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Linux",
			"03000000bd12000015d0000010010000,Tomee SNES USB Controller,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Linux",
			"03000000790000001100000010010000,Retrolink Classic Controller,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,platform:Linux",
			"03000000c9110000f055000011010000,HJC Game GAMEPAD,leftx:a0,lefty:a1,dpdown:h0.4,rightstick:b11,rightshoulder:b5,rightx:a2,start:b9,righty:a3,dpleft:h0.8,lefttrigger:b6,x:b2,dpup:h0.1,back:b8,leftstick:b10,leftshoulder:b4,y:b3,a:b0,dpright:h0.2,righttrigger:b7,b:b1,platform:Linux",
			"03000000a30600000c04000011010000,Saitek P2900 Wireless Pad,a:b1,b:b2,y:b3,x:b0,start:b12,guide:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b4,righttrigger:b5,platform:Linux",
			"03000000341a000005f7000010010000,GameCube {HuiJia USB box},a:b1,b:b2,y:b3,x:b0,start:b9,guide:,back:,leftstick:,rightstick:,leftshoulder:,dpleft:b15,dpdown:b14,dpright:b13,leftx:a0,lefty:a1,rightx:a5,righty:a2,lefttrigger:a3,righttrigger:a4,rightshoulder:b7,dpup:b12,platform:Linux",
			"030000006e0500000320000010010000,JC-U3613M - DirectInput Mode,platform:Linux,x:b0,a:b2,b:b3,y:b1,back:b10,guide:b12,start:b11,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b8,rightstick:b9,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"030000006f0e00004601000001010000,Rock Candy Wired Controller for Xbox One,platform:Linux,a:b0,b:b1,x:b2,y:b3,leftshoulder:b4,rightshoulder:b5,back:b6,start:b7,guide:b8,leftstick:b9,rightstick:b10,lefttrigger:a2,righttrigger:a5,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000380700001647000010040000,Mad Catz Wired Xbox 360 Controller,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"030000006f0e00003901000020060000,Afterglow Wired Controller for Xbox One,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4,platform:Linux",
			"030000004f04000015b3000010010000,Thrustmaster Dual Analog 4,platform:Linux,a:b0,b:b2,x:b1,y:b3,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b6,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b5,righttrigger:b7",
			"05000000102800000900000000010000,8Bitdo SFC30 GamePad,platform:Linux,x:b4,a:b1,b:b0,y:b3,back:b10,start:b11,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1",
			"03000000d81400000862000011010000,HitBox (PS3/PC) Analog Mode,platform:Linux,a:b1,b:b2,y:b3,x:b0,start:b12,guide:b9,back:b8,leftshoulder:b4,rightshoulder:b5,lefttrigger:b6,righttrigger:b7,leftx:a0,lefty:a1",
			"030000000d0f00000d00000000010000,hori,platform:Linux,a:b0,b:b6,y:b2,x:b1,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,start:b9,guide:b10,back:b8,leftshoulder:b3,rightshoulder:b7,leftx:b4,lefty:b5",
			"03000000ad1b000016f0000090040000,Mad Catz Xbox 360 Controller,platform:Linux,a:b0,b:b1,y:b3,x:b2,start:b7,guide:b8,back:b6,leftstick:b9,rightstick:b10,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5",
			"03000000d814000007cd000011010000,Toodles 2008 Chimp PC/PS3,platform:Linux,a:b0,b:b1,y:b2,x:b3,start:b9,back:b8,leftshoulder:b4,rightshoulder:b5,leftx:a0,lefty:a1,lefttrigger:b6,righttrigger:b7",
			"03000000fd0500000030000000010000,InterAct GoPad I-73000 (Fighting Game Layout),platform:Linux,a:b3,b:b4,y:b1,x:b0,start:b7,back:b6,leftx:a0,lefty:a1,rightshoulder:b2,righttrigger:b5",
			"05000000010000000100000003000000,Nintendo Wiimote,platform:Linux,a:b0,b:b1,y:b3,x:b2,start:b9,guide:b10,back:b8,leftstick:b11,rightstick:b12,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b6,righttrigger:b7",
			"030000005e0400008e02000062230000,Microsoft X-Box 360 pad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000a30600000901000000010000,Saitek P880,a:b2,b:b3,y:b1,x:b0,leftstick:b8,rightstick:b9,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b6,righttrigger:b7,platform:Linux",
			"030000006f0e00000103000000020000,Logic3 Controller,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.0,dpdown:h0.4,dpright:h0.0,dpright:h0.2,dpup:h0.0,dpup:h0.1,leftshoulder:h0.0,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"05000000380700006652000025010000,Mad Catz C.T.R.L.R ,platform:Linux,x:b0,a:b1,b:b2,y:b3,back:b8,guide:b12,start:b9,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:b6,rightshoulder:b5,righttrigger:b7,leftstick:b10,rightstick:b11,leftx:a0,lefty:a1,rightx:a2,righty:a3",
			"030000005e0400008e02000073050000,Speedlink TORID Wireless Gamepad,platform:Linux,x:b2,a:b0,b:b1,y:b3,back:b6,guide:b8,start:b7,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,rightshoulder:b5,righttrigger:a5,leftstick:b9,rightstick:b10,leftx:a0,lefty:a1,rightx:a3,righty:a4",
			"03000000ad1b00002ef0000090040000,Mad Catz Fightpad SFxT,platform:Linux,a:b0,b:b1,y:b3,x:b2,start:b7,guide:b8,back:b6,leftshoulder:b4,rightshoulder:b5,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,lefttrigger:a2,righttrigger:a5",
			"05000000a00500003232000001000000,8Bitdo Zero GamePad,platform:Linux,a:b0,b:b1,x:b3,y:b4,back:b10,start:b11,leftshoulder:b6,rightshoulder:b7,leftx:a0,lefty:a1",
			"030000001008000001e5000010010000,NEXT Classic USB Game Controller,a:b0,b:b1,back:b8,start:b9,rightx:a2,righty:a3,leftx:a0,lefty:a1,platform:Linux",
			"03000000100800000300000010010000,USB Gamepad,platform:Linux,a:b2,b:b1,x:b3,y:b0,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b4,righttrigger:b5",
			"05000000ac0500003232000001000000,VR-BOX,platform:Linux,a:b0,b:b1,x:b2,y:b3,start:b9,back:b8,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a3,righty:a2,lefttrigger:b4,righttrigger:b5",
			"03000000780000000600000010010000,Microntek USB Joystick,platform:Linux,x:b3,a:b2,b:b1,y:b0,back:b8,start:b9,leftshoulder:b6,lefttrigger:b4,rightshoulder:b7,righttrigger:b5,leftx:a0,lefty:a1"
			
		];
		
		Gamepad.addMappings (mappings);
		
		#elseif (ios || tvos)
		
		var mappings = [
			
			"4d466947616d65706164010000000000,MFi Extended Gamepad,a:b0,b:b1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,lefttrigger:a2,leftx:a0,lefty:a1,rightshoulder:b5,righttrigger:a5,rightx:a3,righty:a4,start:b6,x:b2,y:b3,",
			"4d466947616d65706164020000000000,MFi Gamepad,a:b0,b:b1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,rightshoulder:b5,start:b6,x:b2,y:b3,",
			"4d466947616d65706164030000000000,MFi Apple TV Remote,a:b0,b:b1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,leftshoulder:b4,rightshoulder:b5,start:b6,x:b2,y:b3,",
			
		];
		
		Gamepad.addMappings (mappings);
		
		#end
		
		if (renderer != null) {
			
			renderer.create ();
			
		}
		
	}
	
	
	public function focus ():Void {
		
		backend.focus ();
		
	}
	
	
	public function move (x:Int, y:Int):Void {
		
		backend.move (x, y);
		
		__x = x;
		__y = y;
		
	}
	
	
	public function resize (width:Int, height:Int):Void {
		
		backend.resize (width, height);
		
		__width = width;
		__height = height;
		
	}
	
	
	public function setIcon (image:Image):Void {
		
		if (image == null) {
			
			return;
			
		}
		
		backend.setIcon (image);
		
	}
	
	
	public function toString ():String {
		
		return "[object Window]";
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	@:noCompletion private function get_display ():Display {
		
		return backend.getDisplay ();
		
	}
	
	
	@:noCompletion private function get_displayMode ():DisplayMode {
		
		return backend.getDisplayMode ();
		
	}
	
	
	@:noCompletion private function set_displayMode (value:DisplayMode):DisplayMode {
		
		return backend.setDisplayMode (value);
		
	}
	
	
	@:noCompletion private inline function get_borderless ():Bool {
		
		return __borderless;
		
	}
	
	
	@:noCompletion private function set_borderless (value:Bool):Bool {
		
		return __borderless = backend.setBorderless (value);
		
	}
	
	
	@:noCompletion private inline function get_enableTextEvents ():Bool {
		
		return backend.getEnableTextEvents ();
		
	}
	
	
	@:noCompletion private inline function set_enableTextEvents (value:Bool):Bool {
		
		return backend.setEnableTextEvents (value);
		
	}
	
	
	@:noCompletion private inline function get_fullscreen ():Bool {
		
		return __fullscreen;
		
	}
	
	
	@:noCompletion private function set_fullscreen (value:Bool):Bool {
		
		return __fullscreen = backend.setFullscreen (value);
		
	}
	
	
	@:noCompletion private inline function get_height ():Int {
		
		return __height;
		
	}
	
	
	@:noCompletion private function set_height (value:Int):Int {
		
		resize (__width, value);
		return __height;
		
	}
	
	
	@:noCompletion private inline function get_maximized ():Bool {
		
		return __maximized;
		
	}
	
	
	@:noCompletion private inline function set_maximized (value:Bool):Bool {
		
		__minimized = false;
		return __maximized = backend.setMaximized (value);
		
	}
	
	
	@:noCompletion private inline function get_minimized ():Bool {
		
		return __minimized;
		
	}
	
	
	@:noCompletion private function set_minimized (value:Bool):Bool {
		
		__maximized = false;
		return __minimized = backend.setMinimized (value);
		
	}
	
	
	@:noCompletion private inline function get_resizable ():Bool {
		
		return __resizable;
		
	}
	
	
	@:noCompletion private function set_resizable (value:Bool):Bool {
		
		__resizable = backend.setResizable (value);
		return __resizable;
		
	}
	
	
	@:noCompletion private inline function get_scale ():Float {
		
		return __scale;
		
	}
	
	
	@:noCompletion private inline function get_title ():String {
		
		return __title;
		
	}
	
	
	@:noCompletion private function set_title (value:String):String {
		
		return __title = backend.setTitle (value);
		
	}
	
	
	@:noCompletion private inline function get_width ():Int {
		
		return __width;
		
	}
	
	
	@:noCompletion private function set_width (value:Int):Int {
		
		resize (value, __height);
		return __width;
		
	}
	
	
	@:noCompletion private inline function get_x ():Int {
		
		return __x;
		
	}
	
	
	@:noCompletion private function set_x (value:Int):Int {
		
		move (value, __y);
		return __x;
		
	}
	
	
	@:noCompletion private inline function get_y ():Int {
		
		return __y;
		
	}
	
	
	@:noCompletion private function set_y (value:Int):Int {
		
		move (__x, value);
		return __y;
		
	}
	
	
}


#if flash
@:noCompletion private typedef WindowBackend = lime._backend.flash.FlashWindow;
#elseif (js && html5)
@:noCompletion private typedef WindowBackend = lime._backend.html5.HTML5Window;
#else
@:noCompletion private typedef WindowBackend = lime._backend.native.NativeWindow;
#end