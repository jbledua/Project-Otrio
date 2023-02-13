package;

//import flixel.addons.effects.FlxTrail;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
//import flixel.addons.effects.FlxTrail;

//import flixel.tweens.TweenEvent;

class SplashState extends FlxState
{
	private var _timer:Float;
	var _sprite:FlxSprite;
	//var _trail:FlxTrail;
	var spaceText:FlxText;

	override public function create():Void 
	{
		super.create();

		var title = new FlxText(0, 0, FlxG.width, "OTRIO", 64);
		title.alignment = CENTER;
		title.screenCenter();
		title.alpha = 0.15;
		add(title);

		_sprite = new FlxSprite();
		_sprite.loadGraphic("AssetPaths.Logo_P__png", true);
		_sprite.x = (FlxG.width - _sprite.width) / 2;
		_sprite.y = (FlxG.height - _sprite.height) / 2;
		_sprite.scale.set(2, 2);
		add(_sprite);
		_sprite.antialiasing = true;

		_sprite.pixelPerfectRender = false;

		spaceText  = new FlxText(0, FlxG.height - 30, FlxG.width, "Press SPACEBAR to continue");
        spaceText.setFormat(null, 24, FlxColor.WHITE, "center");
        spaceText.y = FlxG.height - spaceText.height - 20;

		FlxTween.color(spaceText, 1, FlxColor.WHITE, FlxColor.RED, {type: PINGPONG});

        add(spaceText);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);

		// Change the text's alpha value to create a blinking effect
		//spaceText.alpha = Math.abs(Math.sin(FlxG.elapsed * 10));
		//spaceText.color = 0xFF0000;

		if (FlxG.keys.pressed.SPACE)
        {
            FlxG.switchState(new PlayerState());
        }
	}
}