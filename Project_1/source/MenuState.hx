package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
//import flixel.util.FlxSound;

class MenuState extends FlxState
{
	public function new() 
	{
		super();
		
		var title:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "OTRIO");
		title.setFormat(null, 64, 0xFFFFFF, "center");
		add(title);
		
		var playButton:FlxButton = new FlxButton(FlxG.width / 2 - 50, FlxG.height / 2, "Play", onPlay);
		//playButton.setSounds(null, null, null, null, 0.5);
		add(playButton);
	}

	private function onPlay():Void 
	{
			FlxG.switchState(new PlayerState());
	}
}