import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.Log;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite
{
    private var playerColor:FlxColor;
    private var pieceSlots:FlxTypedGroup<GamePieceSlot>; 

	public function new(player:Int ,x:Float = 0, y:Float = 0, _width:Int = 300, _height:Int = 100)
    {
        //var PlayerColor:FlxColor;

        // super(x, y);
        super(x - Std.int(_width / 2), y - Std.int(_height / 2));

		// Set the player Color
		switch player
		{
			case 0:
                // Player one is Red
				this.playerColor = FlxColor.fromHSL(0,10,0.5,1);
                //this.playerColor = FlxColor.TRANSPARENT;
			case 1:
                // Player two is Blue
				this.playerColor = FlxColor.fromHSL(240,10,0.5,1);
                //this.playerColor = FlxColor.TRANSPARENT;
			case 2:
                // Player three is green
				this.playerColor = FlxColor.fromHSL(140,10,0.5,1);
                //this.playerColor = FlxColor.TRANSPARENT;
			case 3:
                // Player four is puple
				this.playerColor = FlxColor.fromHSL(300,10,0.5,1);
                //this.playerColor = FlxColor.TRANSPARENT;
			default:
				this.playerColor = FlxColor.TRANSPARENT;
		}

        makeGraphic(_width,_height,this.playerColor);

        // Creat the game slots
        pieceSlots = new FlxTypedGroup<GamePieceSlot>(3);
        pieceSlots.add(new GamePieceSlot(this.getCenter().x - 100, this.getCenter().y));
        pieceSlots.add(new GamePieceSlot(this.getCenter().x, this.getCenter().y));
        pieceSlots.add(new GamePieceSlot(this.getCenter().x + 100, this.getCenter().y));
        //pieceSlots.

    }
    public function getPieceSlots():FlxTypedGroup<GamePieceSlot>
    {
        return pieceSlots;
    }

    public function getCenter():FlxPoint
    {
        // Returns the center point of the player
        //return new FlxPoint(this.x + Std.int(this.height/2),this.y + Std.int(this.width/2));
        return new FlxPoint(this.x + Std.int(this.width/2),this.y + Std.int(this.height/2));
    }

    public function setAngle(_angle:Float)
    {
        /*/
        if ((_angle == 90)||(_angle == -90))
        {
            this.angle = _angle;
            pieceSlots.members[0].setPosition(this.getCenter().x, this.getCenter().y - 100);
            pieceSlots.members[2].setPosition(this.getCenter().x, this.getCenter().y + 100);
        }
        //*/
        switch _angle
        {
            case 90:
                this.angle = _angle;
                pieceSlots.members[0].setPosition(this.getCenter().x, this.getCenter().y - 100);
                pieceSlots.members[2].setPosition(this.getCenter().x, this.getCenter().y + 100);
            case -90:
                this.angle = _angle;
                pieceSlots.members[0].setPosition(this.getCenter().x, this.getCenter().y - 100);
                pieceSlots.members[2].setPosition(this.getCenter().x, this.getCenter().y + 100);
            default:
                Log.trace("Error: Rotation Not handled");
        }
        //*/
        
    }
    

    public function setColor(_color:FlxColor)
    {
        // Check if color Changed
        if (this.playerColor != _color)
        {
            this.color = this.playerColor;
        }
        else
        {
            Log.trace("Color Not Changed");
        }
        

    }
}
