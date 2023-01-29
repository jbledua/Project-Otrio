package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import haxe.Log;

class PlayState extends FlxState
{
	private var _gamePieces:FlxTypedGroup<GamePiece>;

	private var _gamePlaySlots:FlxTypedGroup<GamePieceSlot>;
	private var _gameStartSlots:FlxTypedGroup<GamePieceSlot>;

	override public function create()
	{
		super.create();

		// Calculate the Center of the sceen
		var _screenCenterX:Int = Std.int(FlxG.width / 2);
		var _screenCenterY:Int = Std.int(FlxG.height / 2);

		// Create Play Slots
		_gamePlaySlots = new FlxTypedGroup<GamePieceSlot>(9);
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX + 100, _screenCenterY - 100));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX, _screenCenterY - 100));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX - 100, _screenCenterY - 100));

		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX + 100, _screenCenterY));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX, _screenCenterY));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX - 100, _screenCenterY));

		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX + 100, _screenCenterY + 100));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX, _screenCenterY + 100));
		_gamePlaySlots.add(new GamePieceSlot(_screenCenterX - 100, _screenCenterY + 100));

		// Set Play Slots Color
		for (i in 0..._gamePlaySlots.length)
			_gamePlaySlots.members[i].setColor(FlxColor.CYAN);
		add(_gamePlaySlots);

		// Create Game Pieces
		_gamePieces = new FlxTypedGroup<GamePiece>(12);
		_gamePieces.add(new GamePiece(_screenCenterX - 200, _screenCenterY - 100, 0));
		_gamePieces.add(new GamePiece(_screenCenterX - 200, _screenCenterY, 0));
		_gamePieces.add(new GamePiece(_screenCenterX - 200, _screenCenterY + 100, 0));

		_gamePieces.add(new GamePiece(_screenCenterX + 200, _screenCenterY - 100, 1));
		_gamePieces.add(new GamePiece(_screenCenterX + 200, _screenCenterY, 1));
		_gamePieces.add(new GamePiece(_screenCenterX + 200, _screenCenterY + 100, 1));

		_gamePieces.add(new GamePiece(_screenCenterX - 100, _screenCenterY + 200, 2));
		_gamePieces.add(new GamePiece(_screenCenterX, _screenCenterY + 200, 2));
		_gamePieces.add(new GamePiece(_screenCenterX + 100, _screenCenterY + 200, 2));

		_gamePieces.add(new GamePiece(_screenCenterX - 100, _screenCenterY - 200, 3));
		_gamePieces.add(new GamePiece(_screenCenterX, _screenCenterY - 200, 3));
		_gamePieces.add(new GamePiece(_screenCenterX + 100, _screenCenterY - 200, 3));

		add(_gamePieces);
	}

	override public function update(elapsed:Float)
		{
			super.update(elapsed);
	
			// The left mouse button has just been pressed
			if (FlxG.mouse.justPressed)
			{
				for (i in 0..._gamePieces.length)
				{
					if (FlxG.mouse.overlaps(_gamePieces.members[i]))
					{
						Log.trace("Piece " + Std.string(i) + " Up");
						_gamePieces.members[i].onGrab();
					}
				}
			}
	
			// The left mouse button has just been pressed
			if (FlxG.mouse.justReleased)
			{
				for (i in 0..._gamePieces.length)
				{
					if (FlxG.mouse.overlaps(_gamePieces.members[i]))
					{
						// Std.string(i)
						Log.trace("Piece " + Std.string(i) + " Down");
						_gamePieces.members[i].onDrop();
					}
	
					// Check if Pieces are on Playing Slots
					for (j in 0..._gamePlaySlots.length)
					{
						//
						if (_gamePieces.members[i].overlaps(_gamePlaySlots.members[j]))
						{
							Log.trace("On Slot " + Std.string(j));
						}
					}
				}
			}

		}
}
