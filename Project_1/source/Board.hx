import flixel.util.FlxSignal;
import openfl.Vector;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Log;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Board extends FlxSprite
{
    private var slots:FlxTypedGroup<Slot>;

    private var getPieces:FlxSignal;

    public function new(x:Float = 0, y:Float = 0)
	{
        var _width = 300;
        var _hieght = 300;
        

        super(x - Std.int(_width/2),y - Std.int(_hieght/2));

        // Replace this with Board graphic
        makeGraphic(_width,_hieght,FlxColor.WHITE);
        
        slots = new FlxTypedGroup<Slot>(9);
        
        //*
        // Create slots
        for (i in 0...slots.maxSize)
        {
            slots.add(new Slot());
        }
        //*/
        /*
        // Create Top Row
        slots.add(new Slot());
        slots.add(new Slot());
        slots.add(new Slot());

        // Create Middle Row
        slots.add(new Slot());
        slots.add(new Slot());
        slots.add(new Slot());

        // Create Bottom Row
        slots.add(new Slot());
        slots.add(new Slot());
        slots.add(new Slot());
        //*/

        // Update 
        updateSlotPos();
        
    }

    public override function setPosition(x:Float = 0.0, y:Float = 0.0) 
    {
        // Sets Position from center instead of the top right corner
        super.setPosition(x - Std.int(width / 2), y - Std.int(height / 2));

        updateSlotPos();
    }

    private function updateSlotPos() 
    {
        var slotOffset = 100;

        // Update Top Row
        this.slots.members[0].setPosition(this.getCenter().x + slotOffset,this.getCenter().y + slotOffset);
        this.slots.members[1].setPosition(this.getCenter().x,this.getCenter().y + slotOffset);
        this.slots.members[2].setPosition(this.getCenter().x - slotOffset,this.getCenter().y + slotOffset);
        
        // Update Middle Row
        this.slots.members[3].setPosition(this.getCenter().x + slotOffset,this.getCenter().y);
        this.slots.members[4].setPosition(this.getCenter().x,this.getCenter().y);
        this.slots.members[5].setPosition(this.getCenter().x - slotOffset,this.getCenter().y);

        // Update Bottom Row
        this.slots.members[6].setPosition(this.getCenter().x + slotOffset,this.getCenter().y - slotOffset);
        this.slots.members[7].setPosition(this.getCenter().x,this.getCenter().y - slotOffset);
        this.slots.members[8].setPosition(this.getCenter().x - slotOffset,this.getCenter().y - slotOffset);
    }

    public function getCenter():FlxPoint
    {
        return new FlxPoint(this.x + Std.int(this.width/2),this.y + Std.int(this.height/2));
    }

    public function getSlots():FlxTypedGroup<Slot>
    {
        return this.slots;
    }
     
    public function readValues():Array<Array<Array<Int>>>
    {
        // Not Functioning yet
        var _board:Array<Array<Array<Int>>> = [[[-1],[-1],[-1]],[[-1],[-1],[-1]],[[-1],[-1],[-1]]];

        return _board;
    }
}