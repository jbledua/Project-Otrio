import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Log;

class Piece extends FlxSprite
{
	private var pieceSize:Int = 1;
	private var pickedUp:Bool = false;
	private var locked:Bool = false;
	private var parentSlot:Slot;
	private var startPosition:FlxPoint;

	public function setStartPosition(_point:FlxPoint) 
	{
		this.startPosition = _point;
	}

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
				// Replace this with small piece sprit
				_pieceSize = 10;
				makeGraphic(_pieceSize, _pieceSize, _color);
			case 1:
				// Replace this with medium piece sprit
				_pieceSize = 30;
				makeGraphic(_pieceSize, _pieceSize, _color);
			case 2:
				// Replace this with large piece sprit
				_pieceSize = 50;
				makeGraphic(_pieceSize, _pieceSize, _color);
			default:
				_pieceSize = 30;
				makeGraphic(_pieceSize, _pieceSize, _color);
		}

		this.startPosition = new FlxPoint(0,0);
	}

	public function setLocked(_locked:Bool) 
	{
		this.locked = _locked;
	}

	public function isLocked():Bool
	{
		return this.locked;
	}


	public override function setPosition(x:Float = 0.0, y:Float = 0.0) 
	{
		// Sets Position from center instead of the top right corner
		super.setPosition(x - Std.int(width / 2), y - Std.int(height / 2));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (this.pickedUp)
			this.setPosition(FlxG.mouse.getPosition().x,FlxG.mouse.getPosition().y);
			
		//this.setPosition(FlxG.mouse.getPosition().x - Std.int(this.height / 2), FlxG.mouse.getPosition().y - Std.int(this.height / 2));
	}

	public function onGrab()
	{
		if(this.locked)
		{
			this.pickedUp = true;
			
			this.scale.x = 1.5;
			this.scale.y = 1.5;
	
			// Add pick up sound here
		}
		else
		{
			Log.trace("Locked");

			// Add Error animation
			// Add error sound here
		}

	}

	public function onDrop()
	{
		this.pickedUp = false;

		// Replace this with drop up animation
		this.scale.x = 1;
		this.scale.y = 1;

		// Add drop up sound here

		//if(this.getPosition == this.)
	}

	public function isDropped()
	{
		return this.pickedUp;
	}

	public function setParentSlot(_slot:Slot)
	{
		Log.trace("Set Parent");
		this.parentSlot = _slot;
	}
	public function getParentSlot():Slot
	{
		return this.parentSlot;
	}

	public function moveToParent()
	{
		Log.trace("Move to " + Std.string(this.parentSlot.getCenter().x) + "," + Std.string(this.parentSlot.getCenter().y));
	}
	/*
	public function moveTo(_PieceSlot:Slot)
	{
		Log.trace("Move to " + Std.string(_PieceSlot.getCenter().x) + "," + Std.string(_PieceSlot.getCenter().y));
	}
	//*/
	public function moveToStart()
	{
		this.moveTo(this.startPosition);
	}

	public function moveTo(_point:FlxPoint)
	{
		Log.trace("Move to " + Std.string(_point.x) + "," + Std.string(_point.y));

		var _tween:FlxTween = FlxTween.tween(this, { x: _point.x - Std.int(width / 2), y: _point.y - Std.int(height / 2)}, 0.5);

	}
}
