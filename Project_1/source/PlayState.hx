package;

import flixel.FlxSprite;
import openfl.display.Sprite;
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

	private var _gamePlayers:FlxTypedGroup<Player>;
	private var _tempPlayer:Player;

	override public function create()
	{
		super.create();

		// Calculate the Center of the sceen
		var _screenCenterX:Int = Std.int(FlxG.width / 2);
		var _screenCenterY:Int = Std.int(FlxG.height / 2);
		
		// FOR TESTING: Created an alignemt grid
		createAlignGrid();

		_gamePlayers = new FlxTypedGroup<Player>(4);
		_gamePlayers.add(new Player(0,_screenCenterX - 200,_screenCenterY));
		_gamePlayers.add(new Player(1,_screenCenterX + 200,_screenCenterY));
		//_gamePlayers.add(new Player(2,_screenCenterX ,_screenCenterY - 200));
		//.add(new Player(3,_screenCenterX ,_screenCenterY + 200));
		add(_gamePlayers);

		

		// Rotate the Left and right players
		_gamePlayers.members[0].setAngle(90);
		_gamePlayers.members[1].setAngle(-90);

		for (i in 0..._gamePlayers.length)
		{
			add(_gamePlayers.members[i].getPieceSlots());
		}

		//add(_gamePlayers.members[0].getPieceSlots());
		//add(_gamePlayers.members[1].getPieceSlots());
		//add(_gamePlayers.members[2].getPieceSlots());
		//add(_gamePlayers.members[3].getPieceSlots());

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

		/*
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
		//*/
		//add(_gamePieces);
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

	} // End Update

	public function createAlignGrid() 
	{
		var slotOffset:Int = 100;
		var playerOffset:Int = 100;

		// Calculate the Center of the sceen
		var _screenCenterX:Int = Std.int(FlxG.width / 2);
		var _screenCenterY:Int = Std.int(FlxG.height / 2);

		// Center Horizontal
		var _lineCH:FlxSprite = new FlxSprite();
		_lineCH.makeGraphic(1280,1,FlxColor.WHITE);
		_lineCH.setPosition(0,_screenCenterY);
		add(_lineCH);


		// Top Horizontal
		var _lineTH:FlxSprite = new FlxSprite();
		_lineTH.makeGraphic(1280,1,FlxColor.WHITE);
		_lineTH.setPosition(0,_screenCenterY-slotOffset);
		add(_lineTH);

		// Top Player Horizontal
		var _lineTPH:FlxSprite = new FlxSprite();
		_lineTPH.makeGraphic(1280,1,FlxColor.GREEN);
		_lineTPH.setPosition(0,_screenCenterY-slotOffset-playerOffset);
		add(_lineTPH);

		// Bottom Horizontal
		var _lineBH:FlxSprite = new FlxSprite();
		_lineBH.makeGraphic(1280,1,FlxColor.WHITE);
		_lineBH.setPosition(0,_screenCenterY+slotOffset);
		add(_lineBH);

		// Bottom Player Horizontal
		var _lineBPH:FlxSprite = new FlxSprite();
		_lineBPH.makeGraphic(1280,1,FlxColor.PURPLE);
		_lineBPH.setPosition(0,_screenCenterY+slotOffset+playerOffset);
		add(_lineBPH);

		// Center Vertical
		var _lineCV:FlxSprite = new FlxSprite();
		_lineCV.makeGraphic(1,720,FlxColor.WHITE);
		_lineCV.setPosition(_screenCenterX,0);
		add(_lineCV);

		// Right Vertical
		var _lineRV:FlxSprite = new FlxSprite();
		_lineRV.makeGraphic(1,720,FlxColor.WHITE);
		_lineRV.setPosition(_screenCenterX+slotOffset,0);
		add(_lineRV);

		// Right Player Vertical
		var _lineRPV:FlxSprite = new FlxSprite();
		_lineRPV.makeGraphic(1,720,FlxColor.BLUE);
		_lineRPV.setPosition(_screenCenterX+slotOffset+playerOffset,0);
		add(_lineRPV);

		// Left Vertical
		var _lineLV:FlxSprite = new FlxSprite();
		_lineLV.makeGraphic(1,720,FlxColor.WHITE);
		_lineLV.setPosition(_screenCenterX-slotOffset,0);
		add(_lineLV);

		// Left Player Vertical
		var _lineLPV:FlxSprite = new FlxSprite();
		_lineLPV.makeGraphic(1,720,FlxColor.RED);
		_lineLPV.setPosition(_screenCenterX-slotOffset-playerOffset,0);
		add(_lineLPV);
		
	} // Enc createAlignGrid
}
