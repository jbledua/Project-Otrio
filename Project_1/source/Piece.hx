import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Log;

class Piece extends FlxSprite
{
	private var pieceSize:Int = 1;

	public function getPieceSize()
	{
		return this.pieceSize;
	}

	public function setColor(_color:FlxColor)
		{
			this.color = _color; 
		}
	
		public function getColor(_color:FlxColor)
		{
			return this.color;
		}

	public function new(_size:Int = 1,_color:FlxColor = FlxColor.WHITE, _x:Float = 0, _y:Float = 0)
	{
		super(x - Std.int(width / 2), y - Std.int(height / 2));

		var _pieceSize:Int;

		// Set the Piece Size
		switch _size
		{
			case 0:
				_pieceSize = 10;
				//this.origin.set(5, 5);
			case 1:
				_pieceSize = 30;
				//this.origin.set(15, 15);
			case 2:
				_pieceSize = 50;
				//this.origin.set(25, 25);
			default:
				_pieceSize = 30;
				//this.origin.set(15, 15);
		}

		makeGraphic(_pieceSize, _pieceSize, _color);
	}


	public override function setPosition(x:Float = 0.0, y:Float = 0.0) 
	{
		// Sets Position from center instead of the top right corner
		super.setPosition(x - Std.int(width / 2), y - Std.int(height / 2));
	}

	private var pickedUp:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.pickedUp)
			this.setPosition(FlxG.mouse.getPosition().x,FlxG.mouse.getPosition().y);
			
		//this.setPosition(FlxG.mouse.getPosition().x - Std.int(this.height / 2), FlxG.mouse.getPosition().y - Std.int(this.height / 2));
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

	public function moveTo(_PieceSlot:Slot)
	{
		Log.trace("Move to " + Std.string(_PieceSlot.getCenter().x) + "," + Std.string(_PieceSlot.getCenter().y));
	}
}
