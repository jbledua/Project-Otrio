package;

import flixel.util.FlxSignal;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import openfl.display.Sprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import haxe.Log;

class PlayState extends FlxState
{

	private var turnIndex:Int = 0;
	private var players:FlxTypedGroup<Player>;
	private var board:Board;

	override public function create()
	{
		super.create();
		
		// Calculate the Center of the sceen
		var _screenCenterX:Int = Std.int(FlxG.width / 2);
		var _screenCenterY:Int = Std.int(FlxG.height / 2);
		
		// Create Board
		board = new Board(_screenCenterX,_screenCenterY);
		//board.screenCenter();
		add(board);
		add(board.getSlots());

		// TEMPORARY: Board until sprites are added  
		this.drawBoard();

		// FOR TESTING: Created an alignemt grid
		//createAlignGrid();

	} // End create

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// FOR TESTING: Press N to go to next turn 
		if (FlxG.keys.justPressed.N)
		{
			this.endTurn();
		}

		// FOR TESTING: Press R to reset pieces
		if (FlxG.keys.justPressed.R)
		{
			this.players.members[this.turnIndex].resetPiceces();
		}

		if (FlxG.mouse.justPressed)
		{
			// Add all Slot and Pieces from all Players
			for (i in 0...players.length)
			{

				var tempPieces = players.members[i].getPieces();
				var j = tempPieces.length-1;

				// Check if the mouse clicked any of the pieces
				// Needs to loop through in reverse to pick up the piece on top
				while(j >= 0)
				{
					if(FlxG.mouse.overlaps(tempPieces.members[j]))
					{
						tempPieces.members[j].onGrab();

						// Stop Checking after a piece is picked up
						break;
					}
					j--;
				}
			}
		}

		if (FlxG.mouse.justReleased)
		{
			// Add all Slot and Pieces from all Players
			for (i in 0...players.length)
			{

				var tempPieces = players.members[i].getPieces();

				for (j in 0...tempPieces.length)
				{
					if(FlxG.mouse.overlaps(tempPieces.members[j]))
					{
						tempPieces.members[j].onDrop();
						var pieceMoved = false;

						var _tempBoardSlots:FlxTypedGroup<Slot> = this.board.getSlots();

						for (k in 0..._tempBoardSlots.length)
						{
							if(_tempBoardSlots.members[k].overlaps(tempPieces.members[j]))
							{
								// FOR TESTING
								Log.trace("On Board slot " + k);

								if(players.members[i].hasPlayerMoved())
								{
									players.members[i].setMoved(j);

									// Move Piece to slot center
									tempPieces.members[j].moveTo(_tempBoardSlots.members[k].getCenter());

									pieceMoved = true;

								}
								else 
								{
									//nplayers.members[i]
									// // Move Piece to slot start
									// if(tempPieces.members[j].isLocked())
									// {
									// 	tempPieces.members[j].moveToStart();

									// }
								}

								

								//var _sprite:FlxSprite = tempPieces.members[j];

								//tween = FlxTween.tween(sprite, { x:600, y:800 }, 2);

								//var _tween:FlxTween = FlxTween.tween(_sprite, { x: _tempBoardSlots.members[k].getCenter().x, y: _tempBoardSlots.members[k].getCenter().y }, 2.0);
							}

						}

						if(pieceMoved == false)
						{
							// Move Piece to slot start
							if(tempPieces.members[j].isLocked())
							{
								tempPieces.members[j].moveToStart();

								if(players.members[i].getMoved() == turnIndex)
									players.members[i].setMoved(-1);
							}
						}

					}
				}
			}
		}
		

	} // End Update

	public function endTurn()
	{
		// FOR TESTING
		Log.trace("Player " + this.turnIndex);

		// End Current turn
		this.players.members[this.turnIndex].endTurn();

		// Increment turnIndex and loop
		if(this.turnIndex < this.players.length - 1)
			this.turnIndex++;
		else
			this.turnIndex = 0;

		this.checkForWin();

		// Start Next turn
		this.players.members[this.turnIndex].startTurn();

	}

	public function checkForWin() 
	{
		var _win = false;

		// Add Check for Win Condition here
		Log.trace("Check for Win (Not implemented yet)");

		return _win;
	}

	public function getPieces()
	{
		var _tempPieces:FlxTypedGroup<Piece> = new FlxTypedGroup<Piece>(3);
	}

	public function drawBoard() 
	{
		// Center Horizontal
		var _line1:FlxSprite = new FlxSprite();
		_line1.makeGraphic(250,5,FlxColor.BLACK);
		_line1.screenCenter();
		_line1.y = _line1.y + 50;
		add(_line1);

		var _line2:FlxSprite = new FlxSprite();
		_line2.makeGraphic(250,5,FlxColor.BLACK);
		_line2.screenCenter();
		_line2.y = _line2.y - 50;
		add(_line2);

		var _line3:FlxSprite = new FlxSprite();
		_line3.makeGraphic(5,250,FlxColor.BLACK);
		_line3.screenCenter();
		_line3.x = _line3.x + 50;
		add(_line3);

		
		var _line4:FlxSprite = new FlxSprite();
		_line4.makeGraphic(5,250,FlxColor.BLACK);
		_line4.screenCenter();
		_line4.x = _line4.x - 50;
		add(_line4);
 
	} // End drawBoard

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
		
	} // End createAlignGrid

} // End PlayState
