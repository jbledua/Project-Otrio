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

	private var players:FlxTypedGroup<Player>;
	private var board:Board;

	override public function create()
	{
		super.create();

		// Calculate the Center of the sceen
		var _screenCenterX:Int = Std.int(FlxG.width / 2);
		var _screenCenterY:Int = Std.int(FlxG.height / 2);
		
		// FOR TESTING: Created an alignemt grid
		//createAlignGrid();

		// Create Board
		board = new Board(_screenCenterX,_screenCenterY);
		add(board);
		add(board.getSlots());

		// Create Players
		players = new FlxTypedGroup<Player>(4);
		players.add(new Player(0,_screenCenterX - 200,_screenCenterY));
		players.add(new Player(1,_screenCenterX + 200,_screenCenterY));
		players.add(new Player(2,_screenCenterX ,_screenCenterY - 200));
		players.add(new Player(3,_screenCenterX ,_screenCenterY + 200));
		add(players);

		// Rotate the Left and right players
		players.members[0].setAngle(90);
		players.members[1].setAngle(-90);

		// Add all Slot and Pieces from all Players
		for (i in 0...players.length)
		{
			add(players.members[i].getSlots());
			add(players.members[i].getPieces());
		}

	} // End create

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			// Add all Slot and Pieces from all Players
			for (i in 0...players.length)
			{

				var tempPieces = players.members[i].getPieces();


				var j = tempPieces.length-1;
				//for (j in 0...tempPieces.length)
				while(j >= 0)
				{
					if(FlxG.mouse.overlaps(tempPieces.members[j]))
					{
						tempPieces.members[j].onGrab();

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
		
	} // End createAlignGrid

} // End PlayState
