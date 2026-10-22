package sw2cm.browser.windows;


import haxe.ui.containers.windows.WindowManager;
import haxe.ui.containers.windows.Window;

import haxe.ui.events.MouseEvent;


@:build(haxe.ui.ComponentBuilder.build("assets/windows/about-window.xml"))
class AboutWindow extends Window {
	public function new()
	{
		super();

		this.minimizable = false;
		this.maximizable = false;
		this.collapsable = false;
	}

	@:bind(buttonAboutClose, MouseEvent.CLICK)
	private function onClickAboutClose(e:MouseEvent) : Void
	{
		WindowManager.instance.closeWindow(this);
	}
}