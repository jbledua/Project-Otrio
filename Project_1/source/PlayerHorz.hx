import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayerHorz extends Player
{

    override public function new(_player:Int ,_x:Float = 0, _y:Float = 0, _width:Int = 300, _height:Int = 100)
    {
        super(_player ,_x, _y, _width, _height);

        // Creat the game slots
        slots = new FlxTypedGroup<Slot> (3);
        createSlots();

        // Creat the game pieces
        pieces = new FlxTypedGroup<Piece>(9);
        super.createPieces();

    }

    private function createSlots() 
    {
         slots.add(new Slot(this.getCenter().x - 100, this.getCenter().y));
         slots.add(new Slot(this.getCenter().x, this.getCenter().y));
         slots.add(new Slot(this.getCenter().x + 100, this.getCenter().y));
    }
}