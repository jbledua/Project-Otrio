import js.html.AbortController;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Log;
import flixel.group.FlxGroup.FlxTypedGroup;



class Player extends FlxSprite
{

    //private var playerColor:FlxColor;
    private var slots:FlxTypedGroup<Slot>;
    private var pieces:FlxTypedGroup<Piece>;
    private var player:Int;

    private var colorPrimary:FlxColor;
    private var colorLight:FlxColor;
    private var colorDark:FlxColor;
    private var colorBackground:FlxColor;

    private var pieceMoved:Int = -1;
    private var board:Board;

    private var type:Int = 0;

    public function setBoard(_board:Board) 
    {
        this.board = _board;
    }

	public function new(_player:Int ,x:Float = 0, y:Float = 0, _type:Int = 0, _width:Int = 300, _height:Int = 100)
    {

        // super(x, y);
        

        this.player = _player;
        this.type = _type;

		setColors(_player);

         // Set the player Color
		switch this.type
		{
            case 0:
                _width = 300;
                _height = 100;
            case 1:
                _width = 100;
                _height = 300;
            default:
                _width = 300;
                _height = 100;
        }

        super(x - Std.int(_width / 2), y - Std.int(_height / 2));

        // Replace this with FlxColor.TRANSPARENT or Board Graphic
        makeGraphic(_width,_height,colorBackground);

        // Creat the game slots
        slots = new FlxTypedGroup<Slot> (3);
        createSlots();

        // Creat the game pieces
        pieces = new FlxTypedGroup<Piece>(9);
        createPieces();

    }

    
    private function createSlots() 
    {
         // Set the player Color
		switch this.type 
		{
            case 0:
                // Horizontal Player
                slots.add(new Slot(this.getCenter().x - 100, this.getCenter().y));
                slots.add(new Slot(this.getCenter().x, this.getCenter().y));
                slots.add(new Slot(this.getCenter().x + 100, this.getCenter().y));
            case 1:
                // Vertical Player
                slots.add(new Slot(this.getCenter().x, this.getCenter().y - 100 ));
                slots.add(new Slot(this.getCenter().x, this.getCenter().y));
                slots.add(new Slot(this.getCenter().x, this.getCenter().y  + 100));    
            default:
                slots.add(new Slot(this.getCenter().x - 100, this.getCenter().y));
                slots.add(new Slot(this.getCenter().x, this.getCenter().y));
                slots.add(new Slot(this.getCenter().x + 100, this.getCenter().y));
        }

    }

    public function setType(_type:Int)
    {
        
    }

    public function setColors(_player:Int)
    {
        // Set the player Color
		switch _player
		{
			case 0:
                // Player one is Red
                colorLight = FlxColor.fromHSB(0,1,1,1);
                colorPrimary = FlxColor.fromHSB(0,1,0.75,1);
                colorDark = FlxColor.fromHSB(0,1,0.5,1);
                colorBackground = FlxColor.fromHSB(0,1,0.25,1);
			case 1:
                // Player two is Blue
                colorLight = FlxColor.fromHSB(240,1,1,1);
                colorPrimary = FlxColor.fromHSB(240,1,0.75,1);
                colorDark = FlxColor.fromHSB(240,1,0.5,1);
                colorBackground = FlxColor.fromHSB(240,1,0.25,1);
			case 2:
                // Player four is puple
                colorLight = FlxColor.fromHSB(300,1,1,1);
                colorPrimary = FlxColor.fromHSB(300,1,0.75,1);
                colorDark = FlxColor.fromHSB(300,1,0.5,1);
                colorBackground = FlxColor.fromHSB(300,1,0.25,1);
			case 3:
                // Player three is green
                colorLight = FlxColor.fromHSB(120,1,1,1);
                colorPrimary = FlxColor.fromHSB(120,1,0.75,1);
                colorDark = FlxColor.fromHSB(120,1,0.5,1);
                colorBackground= FlxColor.fromHSB(120,1,0.25,1);
			default:
				colorPrimary = FlxColor.WHITE;
                colorLight = FlxColor.WHITE;
                colorDark = FlxColor.WHITE;
                colorBackground = FlxColor.WHITE;
		}
    }

    public function getPieces():FlxTypedGroup<Piece>
    {
        return this.pieces;
    }

    public function getSlots():FlxTypedGroup<Slot>
    {
        return this.slots;
    }

    public function getCenter():FlxPoint
    {
        // Returns the center point of the player
        return new FlxPoint(this.x + Std.int(this.width/2),this.y + Std.int(this.height/2));
    }

    public override function setPosition(x:Float = 0.0, y:Float = 0.0) 
    {
        // Sets Position from center instead of the top right corner
        super.setPosition(x - Std.int(width / 2), y - Std.int(height / 2));
    }

    private function createPieces() 
    {
        
        // Create Large Pieces
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));

        // Create Med Pieces
        pieces.add(new Piece(1,colorPrimary));
        pieces.add(new Piece(1,colorPrimary));
        pieces.add(new Piece(1,colorPrimary));

        // Create Small Pieces
        pieces.add(new Piece(0,colorLight));
        pieces.add(new Piece(0,colorLight));
        pieces.add(new Piece(0,colorLight));

        for (i in 0...pieces.length)
        {
            // Add Pieces to the board to be checked later
            //this.board.addPieces(pieces.members[i]);

            var _point:FlxPoint = new FlxPoint(slots.members[i%3].getCenter().x,slots.members[i%3].getCenter().y);
            pieces.members[i].setPosition(_point.x, _point.y);
            pieces.members[i].setStartPosition(_point);
        }

        
    }

    public function onPieceClick()
    {
        Log.trace("In Piece");
    }

    public function startTurn()
    {
        Log.trace("Start Turn");

        pieceMoved = -1;

        // Unlock all Pieces that are not on the board
        for (i in 0...slots.length)
        {
            for (j in 0...pieces.length)
            {
                if(slots.members[i].overlaps(pieces.members[j]))
                {
                    pieces.members[j].setLocked(true);
                }
            }
        }

    }

	public function endTurn()
	{
		Log.trace("End Turn");

        // Lock all Pieces
        for (i in 0...pieces.length)
        {
            pieces.members[i].setLocked(false);
        }
	}

    public function hasPlayerMoved():Bool 
    {
        return (pieceMoved < 0);    
    }

    public function setMoved(_index:Int)
    {
        pieceMoved = _index;
    }

    public function getMoved():Int
    {
        return pieceMoved;
    }

    public function resetPiceces()
    {
        pieceMoved = -1;

        for (i in 0...pieces.length)
        {
            // Check to see if pieces have been move in previous 
            if(pieces.members[i].isLocked())
            {
                pieces.members[i].moveToStart();
            }
        }
    }

}
