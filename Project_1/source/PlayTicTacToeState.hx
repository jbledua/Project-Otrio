import haxe.Log;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayTicTacToeState extends PlayState
{
    override public function create()
        {
            super.create();
    
            // Calculate the Center of the sceen
            var _screenCenterX:Int = Std.int(FlxG.width / 2);
            var _screenCenterY:Int = Std.int(FlxG.height / 2);
            
    
            // // Create One Player and One AI Player
            players = new FlxTypedGroup<Player>(4);
            players.add(new TicTacToePlayer(0,_screenCenterX - 200,_screenCenterY,1));
            players.add(new TicTacToePlayer(1,_screenCenterX + 200,_screenCenterY,1));
            add(players);
    
            // Add all Slot and Pieces from all Players
            for (i in 0...players.length)
            {
                players.members[i].setBoard(this.board);

                add(players.members[i].getSlots());
                add(players.members[i].getPieces());
            }
    
            // Start first turn
            Log.trace("Player " + this.turnIndex);
            this.players.members[this.turnIndex].startTurn();
    
        } // End create
}