package sw2cm.browser.types;


import haxe.Json;

import haxe.ui.components.Image;


class Mod {
	public var name:String;
	public var url:String;
	public var image:String;
	public var description:String;
	public var author:String;
	public var developers:String;
	public var additionalCredits:String;
	public var releaseDate:String;
	public var latestUpdateDate:String;
	public var bugs:String;
	public var base:String;
	public var version:String;
	public var type:String;
	public var empire:String;
	public var levels:String;
	public var difficulty:String;

	private function new()
	{
		
	}	
	
	@:from public static function fromJsonString(data:String) : Mod
	{
		var jsonData:Dynamic = Json.parse(data);
		var mod:Mod = new Mod();

		mod.name = Reflect.getProperty(jsonData, "name");
		mod.url = Reflect.getProperty(jsonData, "url");
		mod.image = Reflect.getProperty(jsonData, "image");
		mod.description = Reflect.getProperty(jsonData, "description");
		mod.author = _getAuthorFromURL(mod.image);
		mod.developers = Reflect.getProperty(jsonData, "developers");
		mod.additionalCredits = Reflect.getProperty(jsonData, "additionalCredits");
		mod.releaseDate = Reflect.getProperty(jsonData, "releaseDate");
		mod.latestUpdateDate = Reflect.getProperty(jsonData, "latestUpdateDate");
		mod.bugs = Reflect.getProperty(jsonData, "bugs");
		mod.base = Reflect.getProperty(jsonData, "base");
		mod.version = Reflect.getProperty(jsonData, "version");
		mod.type = Reflect.getProperty(jsonData, "type");
		mod.empire = Reflect.getProperty(jsonData, "empire");
		mod.levels = Reflect.getProperty(jsonData, "levels");
		mod.difficulty = Reflect.getProperty(jsonData, "difficulty");

		return mod;
	}


	public function getIcon() : Image
	{
		var image:Image = new Image();
		image.resource = this.image;
		image.imageScale = 0.25;

		return image;
	}
	
	public function getAuthorURL() : String
	{
		if (this.author == null || this.author.length == 0) {
			return null;
		}

		
		var key:String = "/mods/";
		var index:Int = this.image.lastIndexOf(key) + key.length + author.length + 1;

		return this.url.substring(0, index) + "author.json";
	}


	private static function _getAuthorFromURL(url:String) : String
	{
		var key:String = "/mods/";
		var index:Int = url.lastIndexOf(key) + key.length;

		return url.substring(index, url.indexOf("/", index));
	}
}