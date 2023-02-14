import flixel.math.FlxPoint;

class TicTacToePlayer extends Player
{
    override private function createPieces() 
    {
        // Create Large Pieces
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));
        pieces.add(new Piece(2,colorDark));

        for (i in 0...pieces.length)
        {
            // Add Pieces to the board to be checked later
            //this.board.addPieces(pieces.members[i]);

            var _point:FlxPoint = new FlxPoint(slots.members[i%3].getCenter().x,slots.members[i%3].getCenter().y);
            pieces.members[i].setPosition(_point.x, _point.y);
            pieces.members[i].setStartPosition(_point);
        }
    }
}