import flixel.util.FlxSignal;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import haxe.Log;
import openfl.Vector;

class Slot extends FlxSprite
{
	private var sprite:FlxSprite;

	private var slotsSizes:Vector<Int>;
	private var pieces:FlxTypedGroup<Piece>;

	private var checkForPiece:FlxSignal;

	public function new(x:Float = 0, y:Float = 0, _width:Int = 50, _height:Int = 50)
	{
		// Move Origin to the center from the top right corner
		super(x - Std.int(_width / 2), y - Std.int(_height / 2));

		slotsSizes = new Vector<Int>(3);
		pieces = new FlxTypedGroup<Piece>(3);

		for (i in 0...3)
		{
			slotsSizes[i] = i;
		
		}

		this.makeGraphic(_width, _height, FlxColor.TRANSPARENT);
	}
	public function addPieces(_piece:Piece)
	{
		Log.trace("Add piece");
		pieces.add(_piece);
	}

	public function removePiece(_piece:Piece):Piece
	{
		Log.trace("Remove piece");
		return pieces.remove(_piece);
	}

	public function setColor(_color:FlxColor)
	{
		this.color = _color; 
	}

	public function getColor(_color:FlxColor)
	{
		return this.color;
	}
	
	public override function setPosition(x:Float = 0.0, y:Float = 0.0) 
	{
		super.setPosition(x - Std.int(width / 2), y - Std.int(height / 2));

		for (i in 0...this.pieces.length)
		{
			this.pieces.members[i].setPosition(this.getCenter().x,this.getCenter().y);
		}

	}


	/*
	// Needs to be fixed - Look into function Overloading
	public function setPosition(_point:FlxPoint) 
	{
		super.setPosition(_point.x - Std.int(width / 2), _point.y - Std.int(height / 2));
	}
	//*/

	public function getCenter()
	{
		// Returns the center point of the player
		return new FlxPoint(this.x + Std.int(this.width/2),this.y + Std.int(this.height/2));
	}

	
}
