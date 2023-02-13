import haxe.Log;

// ADD AI to this class
class PlayerHorzAI extends PlayerHorz
{
    override public function startTurn()
    {
        Log.trace("Start Turn - AI Player");

       

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

        readBoard();
    }

    public function readBoard()
    {
        var _board:Array<Array<Array<Int>>> = this.board.readValues();

        Log.trace("The Board " + _board);
        //[[[-1],[-1],[-1]],[[-1],[-1],[-1]],[[-1],[-1],[-1]]];// = super.board.readValues();
    }
    
    override public function endTurn()
    {
        Log.trace("End Turn - AI Player");

        // Lock all Pieces
        for (i in 0...pieces.length)
        {
            pieces.members[i].setLocked(false);
        }
    }
}