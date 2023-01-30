import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.Log;
import openfl.Vector;

class GamePieceSlot extends FlxSprite
{
	private var sprite:FlxSprite;

	private var slotsFilled:Vector<Bool>;
	private var slotsSizes:Vector<Int>;
	private var pieces:Vector<GamePiece>;

	public function new(x:Float = 0, y:Float = 0, width:Int = 50, height:Int = 50)
	{
		// Move Origin to the center from the top right corner
		super(x - Std.int(width / 2), y - Std.int(height / 2));
		// super(x, y);

		slotsSizes = new Vector<Int>(3);
		slotsFilled = new Vector<Bool>(3);
		pieces = new Vector<GamePiece>(3);

		for (i in 0...3)
		{
			slotsSizes[i] = i;
			slotsFilled[i] = false;
		}

		sprite = makeGraphic(width, height, FlxColor.CYAN);
	}

	public function setColor(_color:FlxColor)
	{
		this.sprite.color = _color;
	}

	public function getCenter()
	{
		var _center:FlxPoint = new FlxPoint(x + Std.int(width / 2), y + Std.int(height / 2));

		return _center;
	}

	public function placePiece(_gamePiece:GamePiece)
	{
		for (i in 0...3)
		{
			if ((slotsSizes[i] == _gamePiece.getPieceSize()) && (!slotsFilled[i]))
			{
				Log.trace("Slot avalible");
			}
		}
	}
}
