package sw2cm.browser;


import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;

import sw2cm.browser.views.MainView;


class Main {
	public static function main() : Void
	{
		var app = new HaxeUIApp();

		Toolkit.theme = "dark";
		Toolkit.init();

		#if html5
		Toolkit.scale = 0.66;
		#end

		app.ready(function() {
			app.addComponent(new MainView());
			app.start();
		});
	}
}
