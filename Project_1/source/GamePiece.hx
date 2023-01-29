import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Log;

class GamePiece extends FlxSprite
{
	private var _pieceSize:Int = 1;

	public function getPieceSize()
	{
		return this._pieceSize;
	}

	public function new(x:Float = 0, y:Float = 0, player:Int = 0, size:Int = 1)
	{
		// super(x, y);
		super(x - Std.int(width / 2), y - Std.int(height / 2));

		var PlayerColor:FlxColor;
		var PieceSize:Int;

		// Set the player Color
		switch player
		{
			case 0:
				PlayerColor = FlxColor.RED;
			case 1:
				PlayerColor = FlxColor.BLUE;
			case 2:
				PlayerColor = FlxColor.PURPLE;
			case 3:
				PlayerColor = FlxColor.GREEN;
			default:
				PlayerColor = FlxColor.BLACK;
		}

		// Set the Piece Size
		switch size
		{
			case 0:
				PieceSize = 10;
				this.origin.set(5, 5);
			case 1:
				PieceSize = 30;
				this.origin.set(15, 15);
			case 2:
				PieceSize = 50;
				this.origin.set(25, 25);
			default:
				PieceSize = 30;
				this.origin.set(15, 15);
		}

		makeGraphic(PieceSize, PieceSize, PlayerColor);
	}

	public function setPlayer(player)
	{
		var PlayerColor:FlxColor;
		// Set the player Color
		switch player
		{
			case 0:
				PlayerColor = FlxColor.RED;
			case 1:
				PlayerColor = FlxColor.BLUE;
			case 2:
				PlayerColor = FlxColor.PURPLE;
			case 3:
				PlayerColor = FlxColor.GREEN;
			default:
				PlayerColor = FlxColor.BLACK;
		}

		this.color = PlayerColor;
	}

	private var pickedUp:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.pickedUp)
			this.setPosition(FlxG.mouse.getPosition().x - this.height / 2, FlxG.mouse.getPosition().y - this.height / 2);
	}

	public function onGrab()
	{
		this.pickedUp = true;

		this.scale.x = 1.5;
		this.scale.y = 1.5;
	}

	public function onDrop()
	{
		this.pickedUp = false;

		this.scale.x = 1;
		this.scale.y = 1;
	}

	public function isDropped()
	{
		return this.pickedUp;
	}

	public function moveTo(_gamePieceSlot:GamePieceSlot)
	{
		Log.trace("Move to " + Std.string(_gamePieceSlot.getCenter().x) + "," + Std.string(_gamePieceSlot.getCenter().y));
	}
}
