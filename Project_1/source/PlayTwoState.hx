import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import haxe.Log;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayTwoState extends PlayState
{
    override public function create()
        {
            super.create();
    
            // Calculate the Center of the sceen
            var _screenCenterX:Int = Std.int(FlxG.width / 2);
            var _screenCenterY:Int = Std.int(FlxG.height / 2);
            
            // FOR TESTING: Created an alignemt grid
            //createAlignGrid();
    
            // // Create Board
            // board = new Board(_screenCenterX,_screenCenterY);
            // add(board);
            // add(board.getSlots());
    
            // // Center Horizontal
            // var _line1:FlxSprite = new FlxSprite();
            // _line1.makeGraphic(250,5,FlxColor.BLACK);
            // _line1.screenCenter();
            // _line1.y = _line1.y + 50;
            // add(_line1);
    
            // var _line2:FlxSprite = new FlxSprite();
            // _line2.makeGraphic(250,5,FlxColor.BLACK);
            // _line2.screenCenter();
            // _line2.y = _line2.y - 50;
            // add(_line2);
    
            // var _line3:FlxSprite = new FlxSprite();
            // _line3.makeGraphic(5,250,FlxColor.BLACK);
            // _line3.screenCenter();
            // _line3.x = _line3.x + 50;
            // add(_line3);
    
            
            // var _line4:FlxSprite = new FlxSprite();
            // _line4.makeGraphic(5,250,FlxColor.BLACK);
            // _line4.screenCenter();
            // _line4.x = _line4.x - 50;
            // add(_line4);
    
            // Create Players
            players = new FlxTypedGroup<Player>(4);
            players.add(new Player(0,_screenCenterX - 200,_screenCenterY,1));
            players.add(new Player(1,_screenCenterX + 200,_screenCenterY,1));
            add(players);
    
            // Add all Slot and Pieces from all Players
            for (i in 0...players.length)
            {
                players.members[i].setBoard(this.board);

                add(players.members[i].getSlots());
                add(players.members[i].getPieces());
            }


            var _mouseHndlr:FlxMouseEventManager = new FlxMouseEventManager();

            // for (i in 0...players.length)
            // {
            //     var _temp:FlxTypedGroup<Piece> = players.members[i].getPieces();

            //     for (j in 0..._temp.length)
            //     {
            //         _mouseHndlr.add(_temp.members[j], mouseUpHndlr, mouseDownHndlr);
            //     }
            //     this.players[i].getPieces()
            //     _mouseHndlr.add(, mouseUpHndlr, mouseDownHndlr);
            // }

            //var arrayText:FlxText  = new FlxText(0,0,0, ">" + board.readValues(),50);
            //arrayText.screenCenter();
            //arrayText.y = 0;
            //add(arrayText);

            this.board.readValues();
    
            // Start first turn
            Log.trace("Player " + this.turnIndex);
            this.players.members[this.turnIndex].startTurn();
    
        } // End create

        private function mouseDownHndlr(_piece:Piece)
        {
            //sprite.

            _piece.onGrab();
            //Log.trace("Piece Graped ");
        }

        private function mouseUpHndlr(_piece:Piece)
        {
            _piece.onDrop();
            //Log.trace("Piece Dropped ");
        }
}