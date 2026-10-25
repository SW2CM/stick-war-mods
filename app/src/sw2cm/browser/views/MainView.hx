package sw2cm.browser.views;


import haxe.Json;

import haxe.ui.components.Label;
import haxe.ui.containers.dialogs.Dialogs;
import haxe.ui.containers.VBox;
import haxe.ui.containers.windows.WindowManager;
import haxe.ui.events.MouseEvent;
import haxe.ui.events.UIEvent;

import openfl.desktop.Clipboard;
import openfl.desktop.ClipboardFormats;
import openfl.events.Event;
import openfl.Lib;
import openfl.net.URLLoader;
import openfl.net.URLRequest;

import sw2cm.browser.types.Mod;
import sw2cm.browser.windows.AboutWindow;


@:build(haxe.ui.ComponentBuilder.build("assets/views/main-view.xml"))
class MainView extends VBox {
	private var _mods:Array<Mod> = null;

	public function new()
	{
		super();

		this._mods = [];

		_getModsFromURL("https://sw2cm.github.io/stick-war-mods/mods/index.json");
	}

	/* TODO: Search bar that doesn't break images.
	@:bind(textSearch, UIEvent.CHANGE)
	private function onTextSearch(e:UIEvent) : Void
	{
		var text:String = cast this.textSearch.text;

		if (text.length == 0) {
			this.modList.dataSource.clearFilter();
			return;
		}

		this.modList.dataSource.filter(function (index:Int, item:Dynamic) {
			if (item.name.toLowerCase().indexOf(text.toLowerCase(), 0) == -1) {
				return false;
			}

			return true;
		});	
	}*/
	
	@:bind(menuAbout, MouseEvent.CLICK)
	private function onClickAbout(e:MouseEvent) : Void
	{
		var aboutWindow:AboutWindow = new AboutWindow();
		WindowManager.instance.addWindow(aboutWindow);
	}
	
	/* TODO: Make this work.
	@:bind(buttonAuthor, MouseEvent.CLICK)
	private function onClickAuthor(e:MouseEvent) : Void
	{
		if (this._mods.length == 0) {
			return;
		}

		var mod:Mod = this._mods[this.modList.selectedIndex];
		if (mod == null || mod.author == null || mod.author.length == 0) {
			return;
		}

		_openURL(mod.getAuthorURL());
	}*/

	@:bind(buttonShare, MouseEvent.CLICK)
	private function onClickShare(e:MouseEvent) : Void
	{
		if (this._mods.length == 0) {
			return;
		}

		var mod:Mod = this._mods[this.modList.selectedIndex];
		if (mod == null || mod.url == null || mod.url.length == 0) {
			return;
		}

		/*
		#if html5
		js.Syntax.code('navigator.share({title: {0}, url: {1}})', mod.name, mod.url);
		#end
		*/

		Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, mod.url);
		Dialogs.messageBox("Copied mod link to the clipboard.", "Info", "info");
	}

	@:bind(buttonDownload, MouseEvent.CLICK)
	private function onClickDownload(e:MouseEvent) : Void
	{
		if (this._mods.length == 0) {
			return;
		}

		var mod:Mod = this._mods[this.modList.selectedIndex];
		if (mod == null || mod.url == null || mod.url.length == 0) {
			return;
		}

		_openURL(mod.url);
	}


	private function onModSelect() : Void
	{
		if (this._mods.length == 0) {
			return;
		}

		var mod:Mod = this._mods[this.modList.selectedIndex];

		this.labelTitle.text = '${mod.name}\n ';
		this.labelDescription.text  = '${mod.description}\n ';
		this.labelDevelopers.text  = '${mod.developers}\n ';
		this.labelAdditionalCredits.text  = '${mod.additionalCredits}\n ';
		this.labelBugs.text = '${mod.bugs}\n ';
		this.labelType.text  = '${mod.type}\n ';
		this.labelEmpire.text  = '${mod.empire}\n ';
		this.labelLevels.text  = '${mod.levels}\n ';
		this.labelDifficulty.text = '${mod.difficulty}\n ';
		this.labelBase.text  = '${mod.base}\n ';
	}


	private function _openURL(url:String) : Void
	{
		var urlRequest:URLRequest = new URLRequest(url);
		Lib.navigateToURL(urlRequest);
	}

	private function _sortMods() : Void
	{
		this._mods.sort(function(a:Mod, b:Mod) : Int {
			var s1:String = a.name.toLowerCase();
			var s2:String = b.name.toLowerCase();

			return s1.toLowerCase() > s2.toLowerCase() ? 1 : s1 < s2 ? -1 : 0;
		});

		this.modList.dataSource.allowCallbacks = false; /* Speed? */

		this.modList.dataSource.clear();
		for (mod in this._mods) {
			this.modList.dataSource.add({
				image: mod.getIcon(),
				name: '${mod.name}\n ',
				version: 'v${mod.version}\n',
				author: '${mod.author}\n',
				releaseDate: '${mod.releaseDate}\n',
				updateDate: '${mod.latestUpdateDate}\n'
			});
		}

		this.modList.dataSource.allowCallbacks = true;

		onModSelect();
	}

	private function _getModsFromURL(url:String) : Void
	{
		var request:URLRequest = new URLRequest(url);
		var loader:URLLoader = new URLLoader(request);

		loader.addEventListener(Event.COMPLETE, function(event:Event) {
			var loader:URLLoader = cast event.target;
			var string = cast (loader.data, String);
			var mods:Array<String> = cast Reflect.getProperty(Json.parse(string), "mods");

			for (mod in mods) {
				_getMod(mod);
			}
		});
	}

	private function _getMod(url:String) : Void
	{
		var request:URLRequest = new URLRequest(url);
		var loader:URLLoader = new URLLoader(request);
		loader.addEventListener(Event.COMPLETE, function(event:Event) {
			var loader:URLLoader = cast event.target;
			var mod:Mod = Mod.fromJsonString(cast (loader.data, String));
			this._mods.push(mod);
			_sortMods();
		});
	}
}