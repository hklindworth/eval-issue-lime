package lime.utils;


import lime._macros.AssetsMacro;
import lime.media.AudioBuffer;
import lime.graphics.Image;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end


class AssetCache {
	
	
	public var audio:Map<String, AudioBuffer>;
	public var enabled:Bool = true;
	public var image:Map<String, Image>;
	public var font:Map<String, Dynamic /*Font*/>;
	public var version:Int;
	
	
	public function new () {
		
		audio = new Map<String, AudioBuffer> ();
		font = new Map<String, Dynamic /*Font*/> ();
		image = new Map<String, Image> ();
		version = AssetsMacro.cacheVersion ();
		
	}
	
	
	public function exists (id:String, ?type:AssetType):Bool {
		
		if (type == AssetType.IMAGE || type == null) {
			
			if (image.exists (id)) return true;
			
		}
		
		if (type == AssetType.FONT || type == null) {
			
			if (font.exists (id)) return true;
			
		}
		
		if (type == AssetType.SOUND || type == AssetType.MUSIC || type == null) {
			
			if (audio.exists (id)) return true;
			
		}
		
		return false;
		
	}
	
	
	public function set (id:String, type:AssetType, asset:Dynamic):Void {
		
		switch (type) {
			
			case FONT:
				font.set(id, asset);
			
			case IMAGE:
				if (!Std.is(asset, Image))
					throw "Cannot cache non-Image asset: " + asset + " as Image";
				
				image.set(id, asset);
			
			case SOUND, MUSIC:
				if (!Std.is(asset, AudioBuffer))
					throw "Cannot cache non-AudioBuffer asset: " + asset + " as AudioBuffer";
				
				audio.set(id, asset);
				
			default:
				throw type + " assets are not cachable";
			
		}
		
	}
	
	
	public function clear (prefix:String = null):Void {
		
		if (prefix == null) {
			
			audio = new Map<String, AudioBuffer> ();
			font = new Map<String, Dynamic /*Font*/> ();
			image = new Map<String, Image> ();
			
		} else {
			
			var keys = audio.keys ();
			
			for (key in keys) {
				
				if (StringTools.startsWith (key, prefix)) {
					
					audio.remove (key);
					
				}
				
			}
			
			var keys = font.keys ();
			
			for (key in keys) {
				
				if (StringTools.startsWith (key, prefix)) {
					
					font.remove (key);
					
				}
				
			}
			
			var keys = image.keys ();
			
			for (key in keys) {
				
				if (StringTools.startsWith (key, prefix)) {
					
					image.remove (key);
					
				}
				
			}
			
		}
		
	}
	
	
}