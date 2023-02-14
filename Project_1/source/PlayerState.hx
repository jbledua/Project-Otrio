package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;

class PlayerState extends FlxState
{
	
	override public function create():Void
	{
		var title:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "OTRIO");
		title.setFormat(null, 64, 0xFFFFFF, "center");
		add(title);

		var buttonGroup:FlxGroup = new FlxGroup();

		var button1:FlxButton = new FlxButton(FlxG.width / 2 - 50, 260, "Two Player",to2Player);
		var button2:FlxButton = new FlxButton(FlxG.width / 2 - 50, 290, "Four Player",to4Player);
		var button3:FlxButton = new FlxButton(FlxG.width / 2 - 50, 320, "Player VS AI",toAIPlayer);

		// button1.screenCenter();
		// button2.screenCenter();
		// button2.y += 25;
		// button3.screenCenter();
		// button3.y += 50;

		add(button1);
		add(button2);
		add(button3);
		
		var _temp:Piece = new Piece();

		_temp.doSomething();

		// button1.screenCenter();
		// button2.screenCenter();
		// button3.screenCenter();

		// buttonGroup.add(button1);
		// buttonGroup.add(button2);
		// buttonGroup.add(button3);

		// var totalWidth:Float = button1.width + button2.width + button3.width;

		// button1.x = (FlxG.width - totalWidth) / 2;
		// button1.y = (FlxG.height - button1.height) / 2;

		// button2.x = button1.x + button1.width;
		// button2.y = button1.y;

		// button3.x = button2.x + button2.width;
		// button3.y = button1.y;

		// add(buttonGroup);

	}

	private function onButtonClicked():Void 
	{
		FlxG.camera.flash(FlxColor.WHITE, 0.33);
		FlxG.switchState(new GameOverState());
	}


	public function to2Player():Void
		{
			// Restart the game by switching to a new instance of the main game state
			FlxG.switchState(new PlayTwoState());
		}

	public function to4Player():Void
	{
		// Restart the game by switching to a new instance of the main game state
		FlxG.switchState(new PlayFourState());
	}

	public function toAIPlayer():Void
	{
		// Restart the game by switching to a new instance of the main game state
		FlxG.switchState(new PlayOneState());
	}

	
}